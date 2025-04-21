/************************************************************************/
/*																		*/
/*								QUASI88									*/
/*																		*/
/************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <SDL.h>
#ifdef	_WIN32
#include <io.h>
#include <fcntl.h>
#include <windows.h>
#endif

#include "quasi88.h"
#include "device.h"

#include "getconf.h"							/* config_init */
#include "suspend.h"							/* stateload_system */
#include "menu.h"								/* menu_about_osd_msg */
#include "keyboard.h"							/* romaji_type */
#include "monitor.h"							/* debug_mode */


/***********************************************************************
 * オプション
 ************************************************************************/
static int oo_env(const char *var, const char *str)
{
	if (SDL_setenv(var, str, 0) != 0) {
		/* 失敗したら警告したほうが親切だけど… */
	}
	return 0;
}

static int o_videodrv(char *str)
{
	return oo_env("SDL_VIDEODRIVER", str);
}

static int o_audiodrv(char *str)
{
	return oo_env("SDL_AUDIODRIVER", str);
}

static int invalid_arg;
static const T_CONFIG_TABLE sdl2_options[] = {

  /* 300 - 349: システム依存オプション */

  /*  -- GRAPHIC -- */
  { 300, "swrender",     X_FIX,  &use_software_rendering,   TRUE,         0,0, 0        },
  { 300, "hwrender",     X_FIX,  &use_software_rendering,   FALSE,        0,0, 0        },
  { 301, "desktopfs",    X_FIX,  &use_desktop_fullscreen,   TRUE,         0,0, 0        },
  { 301, "nodesktopfs",  X_FIX,  &use_desktop_fullscreen,   FALSE,        0,0, 0        },

  /*  -- INPUT -- */
  { 311, "use_joy",      X_FIX,  &use_joydevice,   TRUE,                  0,0, 0        },
  { 311, "nouse_joy",    X_FIX,  &use_joydevice,   FALSE,                 0,0, 0        },
  { 312, "keyboard",     X_INT,  &keyboard_type,   0, 2,                    0, 0        },
  { 313, "keyconf",      X_STR,  &file_keyboard,                        0,0,0, 0        },
  { 314, "menukey",      X_FIX,  &use_menukey,     TRUE,                  0,0, 0        },
  { 314, "nomenukey",    X_FIX,  &use_menukey,     FALSE,                 0,0, 0        },
  { 315, "use_ime",      X_FIX,  &use_ime,         TRUE,                  0,0, 0        },
  { 315, "nouse_ime",    X_FIX,  &use_ime,         FALSE,                 0,0, 0        },

  /*  -- SYSTEM -- */
  { 320, "videodrv",     X_STR,  NULL,             0, 0, o_videodrv,           0        },
  { 321, "audiodrv",     X_STR,  NULL,             0, 0, o_audiodrv,           0        },


  /*  -- 無視 -- (他システムの引数つきオプション) */


  /* 終端 */
  {   0, NULL,           X_INV,                                       0,0,0,0, 0        },
};

static void help_msg_sdl2(void)
{
	fprintf
		(stdout,
		 "  ** GRAPHIC (SDL depend) **\n"
		 "    -hwrender/-swrender     use Hardware/Software rendering [-hwrender]\n"
		 "    -desktopfs/-nodesktopfs Use/Not use desktop-fullscreen [-desktopfs]\n"
		 "  ** INPUT (SDL depend) **\n"
		 "    -use_joy/-nouse_joy     Enable/Disabel system joystick [-use_joy]\n"
		 "    -keyboard <0|1|2>       Set keyboard type (0:config/1:106key/2:101key) [1]\n"
		 "    -keyconf <filename>     Specify keyboard configuration file <filename>\n"
		 "    -menukey/-nomenukey     Right Windows/Command key to menu [-nomenukey]\n"
		 "    -use_ime/-nouse_ime     Enable/Disable IME in menu [-nouseime]\n"
		 "  ** SYSTEM (SDL depend) **\n"
		 "    -videodrv <drv>         do setenv(\"SDL_VIDEODRIVER=drv\")\n"
		 "    -audiodrv <drv>         do setenv(\"SDL_AUDIODRIVER=drv\")\n");
}



/***********************************************************************
 * Windows のコンソール処理
 ************************************************************************/
#if defined(_WIN32) && !defined(_CONSOLE)
#if   USE_MONITOR
static BOOL WINAPI MyHandler(DWORD event)
{
	switch (event) {
	case CTRL_C_EVENT:
		/* Ctrl-C は横取りしたいので、 FALSE を返す */
		return FALSE;

	default:
	/* case CTRL_CLOSE_EVENT: */
	/* case CTRL_BREAK_EVENT: */
	/* case CTRL_LOGOFF_EVENT: */
	/* case CTRL_SHUTDOWN_EVENT: */
		/* その他は、強制終了させたいのだが
		   これだと ↓ 異常終了する。なんかやり方がまずいのか … */

		/* quasi88_exit(0); */

		/* return FALSE; */
		return TRUE;
	}
}

BOOL	use_consele = FALSE;
static void win32_open_console(void)
{
	/* -debug オプション指定時のみ、コンソールを開く */
	if (debug_mode) {
		use_consele = AllocConsole();
		if (use_consele) {
			freopen("CONOUT$", "w", stdout);
			freopen("CONOUT$", "w", stderr);
			freopen("CONIN$", "r", stdin);

			/* Ctrl-C を横取りする */
			SetConsoleCtrlHandler(MyHandler, TRUE);

			{
				/* コンソールを閉じれないようにする
				 * ( 閉じたときの強制終了処理がうまくいかないので… ) */
				HMENU hmenu = GetSystemMenu(GetConsoleWindow(), FALSE);
				RemoveMenu(hmenu, SC_CLOSE, MF_BYCOMMAND);
			}
#ifdef _DEBUG
			printf("**Debug build**\n\n");
			fflush(NULL);
#endif
		}
	}
}
static void win32_close_console(void)
{
	if (use_consele) {
		FreeConsole();
		/* freopen した際の FILE は fclose したほうがいいのか ? */
	}
}
#else
#define	win32_open_console()
#define	win32_close_console()
#endif
#else
#define	win32_open_console()
#define	win32_close_console()
#endif


/***********************************************************************
 * メイン処理
 ************************************************************************/
static void finish(void);

int main(int argc, char *argv[])
{
	int x = 1;

#ifdef  _WIN32
	/* 一部の初期値を改変 (いいやり方はないかな…) */
	romaji_type = 1;					/* ローマ字変換の規則を MS-IME風に */
#endif


	if (config_init(argc, argv,					/* 環境初期化 & 引数処理 */
					sdl2_options, help_msg_sdl2)) {

		win32_open_console();

		if (sdl2_init()) {						/* SDL2関連の初期化 */

			quasi88_atexit(finish);		/* quasi88() 実行中に強制終了した際の
										   コールバック関数を登録する */
			quasi88();							/* PC-8801 エミュレーション */

			sdl2_exit();						/* SDL2関連後始末 */
		}

		win32_close_console();

		config_exit();							/* 引数処理後始末 */

	}

	return 0;
}



/*
 * 強制終了時のコールバック関数 (quasi88_exit()呼出時に、処理される)
 */
static void finish(void)
{
	sdl2_exit();								/* SDL2関連後始末 */
	win32_close_console();
	config_exit();								/* 引数処理後始末 */
}



/***********************************************************************
 * ステートロード／ステートセーブ
 ************************************************************************/

/*      他の情報すべてがロード or セーブされた後に呼び出される。
 *      必要に応じて、システム固有の情報を付加してもいいかと。
 */

int stateload_system(void)
{
	return TRUE;
}

int statesave_system(void)
{
	return TRUE;
}



/***********************************************************************
 * メニュー画面に表示する、システム固有メッセージ
 ************************************************************************/

int menu_about_osd_msg(int req_japanese,
					   int *result_code, const char *message[])
{
	return FALSE;
}
