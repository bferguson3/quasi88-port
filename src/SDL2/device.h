#ifndef DEVICE_H_INCLUDED
#define DEVICE_H_INCLUDED


#include <SDL.h>


/*
 *  src/SDL2/ 以下でのグローバル変数
 */
extern int sdl_mouse_rel_move;			/* マウス相対移動量検知可能か */
extern int sdl_repeat_on;				/* キーリピートONか */



/*
 *  src/SDL2/ 以下でのグローバル変数 (オプション設定可能な変数)
 */
extern int use_software_rendering;		/*SDL_RENDERER_SOFTWARE を使う       */
extern int use_desktop_fullscreen;		/*SDL_WINDOW_FULLSCREEN_DESKTOPを使う*/

extern int use_ime;						/* メニューでIMEを使えるようにする   */

extern int use_menukey;					/* 左Win/左Cmdキーでメニューへ遷移   */
extern int keyboard_type;				/* キーボードの種類                  */
extern char *file_keyboard;				/* キー設定ファイル名                */
extern int use_joydevice;				/* ジョイスティックデバイスを開く?   */



/*
 *      src/SDL2/ 以下でのグローバル関数
 */
int sdl2_init(void);
void sdl2_exit(void);

#endif	/* DEVICE_H_INCLUDED */
