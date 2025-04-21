/***********************************************************************
 * グラフィック処理 (システム依存)
 *
 *      詳細は、 graph.h 参照
 ************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <SDL.h>

#include "quasi88.h"
#include "graph.h"
#include "device.h"

/************************************************************************/

#define	DEBUG_PRINTF	(0)
#define DBGPRINTF(x) if (DEBUG_PRINTF) printf x


/* 以下は static な変数。オプションで変更できるのでグローバルにしてある */

int use_software_rendering = FALSE;		/*SDL_RENDERER_SOFTWARE を使う*/
int use_desktop_fullscreen = TRUE;		/*SDL_WINDOW_FULLSCREEN_DESKTOPを使う*/


/* 以下は、 event.c などで使用する、 OSD なグローバル変数 */

int sdl_mouse_rel_move;					/* マウス相対移動量検知可能か */
int sdl_repeat_on;						/* キーリピートONか */




/************************************************************************/

static T_GRAPH_SPEC graph_spec;			/* 基本情報            */

static int graph_exist;					/* 真で、画面生成済み  */
static T_GRAPH_INFO graph_info;			/* その時の、画面情報  */

static int now_fullscreen;
static int now_width;
static int now_height;


/************************************************************************
 *      SDL2の初期化
 *      SDL2の終了
 ************************************************************************/

int sdl2_init(void)
{
	SDL_version libver;
	SDL_GetVersion(&libver);

	if (verbose_proc) {
		printf("Initializing SDL2 (%d.%d.%d) ... ",
			   libver.major, libver.minor, libver.patch);
		fflush(NULL);
	}

	if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) < 0) {

		if (verbose_proc)
			printf("Failed\n");
		fprintf(stderr, "SDL Error: %s\n", SDL_GetError());

		return FALSE;

	} else {

		if (verbose_proc)
			printf("OK\n");

#if DEBUG_PRINTF
		{
			int i, num;
			int j, max;

			/* 今のビデオドライバと、利用可能なビデオドライバの一覧 */
			printf("video driver = %s\n", SDL_GetCurrentVideoDriver());
			num = SDL_GetNumVideoDrivers();
			for (i = 0; i < num; i++) {
				printf("  %2d: %s\n", i, SDL_GetVideoDriver(i));
			}

			/* 今のオーディオドライバと、利用可能なオーディオドライバの一覧 */
			printf("audio driver = %s\n", SDL_GetCurrentAudioDriver());
			num = SDL_GetNumAudioDrivers();
			for (i = 0; i < num; i++) {
				printf("  %2d: %s\n", i, SDL_GetAudioDriver(i));
			}

			/* 使用可能なレンダリングドライバの一覧 */
			num = SDL_GetNumRenderDrivers();
			printf("rendering driver = %d driver(s)\n", num);
			for (i = 0; i < num; i++) {
				SDL_RendererInfo info;
				if (SDL_GetRenderDriverInfo(i, &info) == 0) {
					Uint32 f = info.flags;
					printf("  %2d: %-16s %c|%c|%c|%c\n", i, info.name,
						   (f & SDL_RENDERER_SOFTWARE) ? 'S' : ' ',
						   (f & SDL_RENDERER_ACCELERATED) ? 'H' : ' ',
						   (f & SDL_RENDERER_PRESENTVSYNC) ? 'V' : ' ',
						   (f & SDL_RENDERER_TARGETTEXTURE) ? 'T' : ' ');
				}
			}

			/* ディスプレイの数と、利用可能なディスプレイモードの一覧 */
			max = SDL_GetNumVideoDisplays();
			for (j = 0; j < max; j++) {
				SDL_DisplayMode mode;
				num = SDL_GetNumDisplayModes(j);
				printf("display[%d] = %d mode(s)\n", j, num);
				for (i = 0; i < num; i++) {
					if (SDL_GetDisplayMode(j, i, &mode) == 0) {
						Uint32 f = mode.format;
						printf("  %2d: %4d x %4d (%2dbpp %s)\n",
							   i, mode.w, mode.h,
							   SDL_BITSPERPIXEL(f), SDL_GetPixelFormatName(f));
					}
				}
			}
		}
#endif
		return TRUE;
	}
}

/************************************************************************/

void sdl2_exit(void)
{
	SDL_Quit();
}


/************************************************************************
 *      グラフィック処理の初期化
 *      グラフィック処理の動作
 *      グラフィック処理の終了
 ************************************************************************/

const T_GRAPH_SPEC *graph_init(void)
{
	int ful_w, ful_h;
	SDL_DisplayMode mode;

	if (verbose_proc) {
		printf("Initializing Graphic System ... OK");
	}

	if (use_desktop_fullscreen) {
		/* デスクトップフルスクリーンなら、最大サイズは無制限にする */
		ful_w = 10000;
		ful_h = 10000;

	} else {
		/* 0番目のディスプレイだけ確認。リストの0番目が一番幅の大きいサイズ */
		if (SDL_GetDisplayMode(0, 0, &mode) == 0) {
			ful_w = mode.w;
			ful_h = mode.h;
		} else {
			ful_w = 0;
			ful_h = 0;
		}
	}


	graph_spec.window_max_width		= 10000;
	graph_spec.window_max_height	= 10000;
	graph_spec.fullscreen_max_width	= ful_w;
	graph_spec.fullscreen_max_height= ful_h;
	graph_spec.forbid_status		= FALSE;
	graph_spec.forbid_half			= FALSE;

	if (verbose_proc) {
		printf(" (FullscreenMax=%dx%d)\n", ful_w, ful_h);
	}

	return &graph_spec;
}

/************************************************************************/

/* T_GRAPH_INFO (画面サイズ、描画バッファのポインタ、使える色数など) を返す
   引数で指示されたどおりになるとは限らない */

static SDL_Window *sdl_window;
static SDL_Renderer *sdl_renderer;
static SDL_Texture *sdl_texture;
static SDL_Surface *sdl_offscreen;

#define	ICON_SIZE	48

const T_GRAPH_INFO *graph_setup(int width, int height,
								int fullscreen, double aspect)
{
	int display_index;
	SDL_DisplayMode desktop;
	int full_width, full_height;
	int depth;
	int byte_per_pixel = 4;
	Uint32 flags;
	const unsigned long *icon_pixel;

	/* まだウインドウが無いならば生成する。この時はまだ全画面にはしない */
	if (graph_exist == FALSE) {

		now_fullscreen = FALSE;
		now_width = width;
		now_height = height;

		flags = 0;
		/* flags |= SDL_WINDOW_RESIZABLE; */

		if (verbose_proc) {
			printf("Screen init ... ");
		}
		if ((sdl_window = SDL_CreateWindow("QUASI88",
										   SDL_WINDOWPOS_UNDEFINED,
										   SDL_WINDOWPOS_UNDEFINED,
										   width, height, flags)) == NULL) {
			return NULL;
		}

		flags = 0;
		if (use_software_rendering) {
			if (verbose_proc) {
				printf("(Using software rendering)");
			}
			flags = SDL_RENDERER_SOFTWARE;
		} else {
			flags = SDL_RENDERER_ACCELERATED;
		}
		if ((sdl_renderer = SDL_CreateRenderer(sdl_window, -1,
											   flags)) == NULL) {
			return NULL;
		}

		SDL_SetRenderDrawColor(sdl_renderer, 0, 0, 0, 255);

#if defined(ICON_SIZE)
#if   (ICON_SIZE == 48)
		icon_pixel = iconimage_get_48x48();
#elif (ICON_SIZE == 32)
		icon_pixel = iconimage_get_32x32();
#elif (ICON_SIZE == 16)
		icon_pixel = iconimage_get_16x16();
#else
#error
#endif
		if (icon_pixel) {
			SDL_Surface *icon_surface;
			Uint32 icon[ ICON_SIZE * ICON_SIZE ];
			int i;

			for (i = 0; i < ICON_SIZE * ICON_SIZE; i++) {
				icon[i] = icon_pixel[i];
			}
			icon_surface =
				SDL_CreateRGBSurfaceFrom(icon, ICON_SIZE, ICON_SIZE,
										 32,
										 ICON_SIZE * sizeof(Uint32),
										 0x00ff0000, 0x0000ff00, 0x000000ff,
										 0xff000000);
			SDL_SetWindowIcon(sdl_window, icon_surface);
			SDL_FreeSurface(icon_surface);
		}
#endif

#if SDL_VERSION_ATLEAST(2, 0, 4)
		/* (Windows) Alt+F4 で SDL_WINDOWEVENT_CLOSE イベントを生成しない */
		SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
#endif
	} else {
		if (verbose_proc) {
			printf("Screen change ... ");
		}
	}

	/* この時点でウインドウはすでにある */
	if (verbose_proc) {
		printf("Req %s:(%dx%d) => ",
			   (fullscreen) ? "full" : "win", width, height);
	}

	/* フルスクリーンが要求されたら、可否の判定と、画面サイズ計算を行う */
	if (fullscreen) {
		SDL_DisplayMode target, closest;

		display_index = SDL_GetWindowDisplayIndex(sdl_window);

		if (use_desktop_fullscreen) {
			flags = SDL_WINDOW_FULLSCREEN_DESKTOP;

			/* デスクトップサイズを取得し それにあわせた画面サイズを計算する */
			if (SDL_GetDesktopDisplayMode(display_index, &desktop) == 0) {

				double desktop_aspect = ((double) desktop.w / desktop.h);
				double request_aspect = ((double) width / height);

				if (aspect >= 0.05) {
					desktop_aspect = aspect;
				}

				if (desktop_aspect <= request_aspect) {
					full_width = width;
					full_height = (int) (width / desktop_aspect);
					full_height = (full_height + 1) & ~1;	/* 2の倍数 */
				} else {
					full_width = (int) (height * desktop_aspect);
					full_width = (full_width + 7) & ~7;		/* 8 の倍数 */
					full_height = height;
				}

				byte_per_pixel = SDL_BYTESPERPIXEL(desktop.format);

				if (verbose_proc) {
					printf("Try (%dx%d),desktop %dx%d => ",
						   full_width, full_height, desktop.w, desktop.h);
				}
			} else {
				fullscreen = FALSE;
			}

		} else {
			flags = SDL_WINDOW_FULLSCREEN;

			/* 最も画面サイズに近いディスプレイモードを取得する */
			target.w = width;
			target.h = height;
			target.format = 0;
			target.refresh_rate = 0;
			target.driverdata = 0;
			if (SDL_GetClosestDisplayMode(display_index, &target, &closest)) {

				full_width = closest.w;
				full_height = closest.h;
				byte_per_pixel = SDL_BYTESPERPIXEL(closest.format);

				if (verbose_proc) {
					printf("Try (%dx%d) => ", full_width, full_height);
				}
			} else {
				fullscreen = FALSE;
			}
		}
	}

	/* 現在、フルスクリーンなら一旦ウインドウに戻す */
	if (now_fullscreen) {
		SDL_SetWindowFullscreen(sdl_window, 0);
		SDL_SetWindowPosition(sdl_window,
							  SDL_WINDOWPOS_CENTERED,
							  SDL_WINDOWPOS_CENTERED);
		now_fullscreen = FALSE;
	}

	/* フルスクリーンに変更する */
	if (fullscreen) {

		SDL_SetWindowSize(sdl_window, full_width, full_height);

		if (SDL_SetWindowFullscreen(sdl_window, flags) == 0) {

			now_fullscreen = TRUE;
			now_width = full_width;
			now_height = full_height;

		} else {
			fullscreen = FALSE;
		}
	}

	/* ウインドウに変更する (フルスクリーンに失敗した時もこっち) */
	if (fullscreen == FALSE) {

		SDL_SetWindowSize(sdl_window, width, height);

		now_fullscreen = FALSE;
		now_width = width;
		now_height = height;

		display_index = SDL_GetWindowDisplayIndex(sdl_window);
		if (SDL_GetDesktopDisplayMode(display_index, &desktop) == 0) {
			byte_per_pixel = SDL_BYTESPERPIXEL(desktop.format);
		}
	}


	/* ウインドウの変更が終わったので、色深度を決定する */

#if     defined(SUPPORT_16BPP) && defined(SUPPORT_32BPP)
	if (byte_per_pixel == 4) {
		depth = 32;					/* 24 だと SDL_CreateRGBSurface で NG? */
	} else if (byte_per_pixel == 2) {
		depth = 16;
	} else {
		depth = 32;
		byte_per_pixel = 4;
	}
#elif   defined(SUPPORT_16BPP)
	depth = 16;
	byte_per_pixel = 2;
#elif   defined(SUPPORT_32BPP)
	depth = 32;
	byte_per_pixel = 4;
#endif

	if (verbose_proc) {
		printf("Res %s:(%dx%d),%dbpp\n", (now_fullscreen) ? "full" : "win",
			   now_width, now_height, depth);
	}


	/* レンダラー、テクスチャー、サーフェスを再設定 */

	if (now_fullscreen == 0) {
		SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "nearest");
	} else {
		SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "linear");
	}
	SDL_RenderSetLogicalSize(sdl_renderer, now_width, now_height);


	if (sdl_offscreen) {
		SDL_FreeSurface(sdl_offscreen);
	}
	/*                                  depth が 24 だとうまくいかない?  ↓ */
	if ((sdl_offscreen = SDL_CreateRGBSurface(0, now_width, now_height, depth,
											  0, 0, 0, 0)) == NULL) {
		return NULL;
	}


	if (sdl_texture) {
		SDL_DestroyTexture(sdl_texture);
	}
	/*                  ピクセルフォーマットは surface にあわせる ↓ */
	if ((sdl_texture = SDL_CreateTexture(sdl_renderer,
										 sdl_offscreen->format->format,
										 SDL_TEXTUREACCESS_STREAMING,
										 now_width, now_height)) == NULL) {
		return NULL;
	}

	/* 暗くなれ */
	/* SDL_SetTextureColorMod(sdl_texture, 128, 128, 128); */


	SDL_RenderClear(sdl_renderer);
	/* SDL_RenderPresent(sdl_renderer); */

#if 0
	{
		int w, h;
		SDL_Rect rect;
		SDL_GetRendererOutputSize(sdl_renderer, &w, &h);
		printf("render output size %dx%d\n", w, h);

		SDL_RenderGetLogicalSize(sdl_renderer, &w, &h);
		printf("render logical size %dx%d\n", w, h);

		SDL_RenderGetViewport(sdl_renderer, &rect);
		printf("render viewport %dx%d+%d+%d\n", rect.w, rect.h, rect.x,
			   rect.y);
	}
#endif

	/* graph_info に諸言をセットする */

	graph_info.fullscreen		= fullscreen;
	graph_info.width			= sdl_offscreen->w;
	graph_info.height			= sdl_offscreen->h;
	graph_info.byte_per_pixel	= byte_per_pixel;
	graph_info.byte_per_line	= sdl_offscreen->pitch;
	graph_info.buffer			= sdl_offscreen->pixels;
	graph_info.nr_color			= 255;
	graph_info.write_only		= TRUE;
	graph_info.broken_mouse		= FALSE;
	graph_info.draw_start		= NULL;
	graph_info.draw_finish		= NULL;
	graph_info.dont_frameskip	= FALSE;

	graph_exist = TRUE;

	return &graph_info;
}

/************************************************************************/

void graph_exit(void)
{
	if (sdl_window) {
		SDL_SetWindowGrab(sdl_window, SDL_FALSE);
	}

	SDL_QuitSubSystem(SDL_INIT_VIDEO);
}

/************************************************************************
 *              色の確保
 *              色の解放
 ************************************************************************/

void graph_add_color(const PC88_PALETTE_T color[],
					 int nr_color, unsigned long pixel[])
{
	int i;
	for (i = 0; i < nr_color; i++) {
		pixel[i] = SDL_MapRGB(sdl_offscreen->format,
							  color[i].red, color[i].green, color[i].blue);
	}
}

/************************************************************************/

void graph_remove_color(int nr_pixel, unsigned long pixel[])
{
	/* 色に関しては何も管理しないので、ここでもなにもしない */
}

/************************************************************************
 *              グラフィックの更新
 ************************************************************************/

void graph_update(int nr_rect, T_GRAPH_RECT rect[])
{
	SDL_Rect drect;
	int i;

	if (nr_rect > 16) {
		fprintf(stderr, "SDL: Maybe Update Failied...\n");
		nr_rect = 16;
	}

#if 0
	for (i = 0; i < nr_rect; i++) {
//		printf("%dx%d+%d+%d, ", rect[i].width, rect[i].height, rect[i].x, rect[i].y);

		drect.x = rect[i].x;
		drect.y = rect[i].y;
		drect.w = rect[i].width;
		drect.h = rect[i].height;

		if (SDL_UpdateTexture(sdl_texture, &drect,
							  ((char *) sdl_offscreen->pixels)
							  + (drect.x * graph_info.byte_per_pixel)
							  + (drect.y * sdl_offscreen->pitch),
							  sdl_offscreen->pitch) < 0) {
			fprintf(stderr, "SDL: Unsuccessful SDL_UpdateTexture\n");
		}
	}
#elif 0
	if (SDL_UpdateTexture
		(sdl_texture, NULL, sdl_offscreen->pixels, sdl_offscreen->pitch) < 0) {
		fprintf(stderr, "SDL: Unsuccessful SDL_UpdateTexture\n");
	}
#else
	for (i = 0; i < nr_rect; i++) {
		unsigned char *pixels;
		int pitch;
		int j;

		drect.x = rect[i].x;
		drect.y = rect[i].y;
		drect.w = rect[i].width;
		drect.h = rect[i].height;

		SDL_LockTexture(sdl_texture, &drect, (void **) &pixels, &pitch);

		for (j = 0; j < drect.h; j++) {
			unsigned char *dst = pixels + (j * pitch);
			unsigned char *src = ((unsigned char *) sdl_offscreen->pixels)
				+ (drect.x * graph_info.byte_per_pixel)
				+ ((drect.y + j) * sdl_offscreen->pitch);
			int size = drect.w * graph_info.byte_per_pixel;
			memcpy(dst, src, size);
		}

		SDL_UnlockTexture(sdl_texture);
	}
#endif

	/* SDL_RenderClear(sdl_renderer); */
	SDL_RenderCopy(sdl_renderer, sdl_texture, NULL, NULL);
	SDL_RenderPresent(sdl_renderer);
}


/************************************************************************
 *              タイトルの設定
 *              属性の設定
 ************************************************************************/

void graph_set_window_title(const char *title)
{
	SDL_SetWindowTitle(sdl_window, title);
}

/************************************************************************/

void graph_set_attribute(int mouse_show, int grab, int keyrepeat_on)
{
	if (mouse_show)
		SDL_ShowCursor(SDL_ENABLE);
	else
		SDL_ShowCursor(SDL_DISABLE);

	if (grab)
		SDL_SetWindowGrab(sdl_window, SDL_TRUE);
	else
		SDL_SetWindowGrab(sdl_window, SDL_FALSE);

	if (keyrepeat_on) {
		sdl_repeat_on = TRUE;
	} else {
		sdl_repeat_on = FALSE;
	}


	if ((mouse_show == FALSE) && grab) {
		SDL_SetRelativeMouseMode(SDL_TRUE);
		sdl_mouse_rel_move = TRUE;
	} else {
		SDL_SetRelativeMouseMode(SDL_FALSE);
		sdl_mouse_rel_move = FALSE;
	}
}
