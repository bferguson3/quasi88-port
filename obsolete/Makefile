###############################################################################
#
# Makefile for quasi88/UNIX (FreeBSD, Linux, Mac OS X and so on...)
#
#	必ず、GNU make が必要です。
#
#			    この Makefile の作成にあたっては XMAME の 
#			    makefile.unix、src/unix/unix.mak を参考にしました。
#			    コンパイル関連の設定については、上記のファイルに
#			    記載されているコメントが役立つかもしれません。
###############################################################################

# X11版、SDL版のいずれかを設定します
#	X11版の場合は、「X11_VERSION」以外の行をコメントアウトしてください。
#	SDL版の場合は、「SDL_VERSION」以外の行をコメントアウトしてください。
#	(SDL版は、 SDL1.2 が必要です)
#
#	「GTK_VERSION」「MINI_VERSION」はコメントアウトのままとしてください。

X11_VERSION	= 1
# SDL_VERSION	= 1
# GTK_VERSION	= 1
# MINI_VERSION	= 1


#######################################################################
# 基本設定
#######################################################################


# (X11/SDL/GTK/MINI)
# QUASI88 で使用する各種ディレクトリを設定します。
#	いくつかは、環境変数や起動時のオプションで指定することができますが、
#	それらの指定がない場合の、デフォルトを設定します。
#	 ~/ は、QUASI88の起動時にホームディレクトリ（$HOME）に展開されます。

# ・ROM用ディレクトリを設定します
#	BASIC の ROMイメージ を検索するディレクトリです。

ROMDIR	= ~/quasi88/rom/


# ・DISK用ディレクトリを設定します
#	起動時に、引数で指定したイメージファイルを開く際に、
#	そのファイルを検索するディレクトリです。

DISKDIR	= ~/quasi88/disk/


# ・TAPE用ディレクトリを設定します
#	TAPE のイメージを置くディレクトリです。

TAPEDIR	= ~/quasi88/tape/


# ・スナップショット保存先ディレクトリを設定します
#	スクリーンスナップショットの画像ファイルが保存されるディレクトリです。
#	コメントアウトされている場合は、カレントディレクトリになります。

# SNAPDIR = ~/


# ・ステートファイル保存先ディレクトリを設定します
#	ステートセーブ時のファイルが保存されるディレクトリです。
#	コメントアウトされている場合は、 ~/.quasi88/state/ になります。

# STATEDIR = ~/.quasi88/state/


# ・個別設定ファイル用ディレクトリを設定します
#	起動時にディスクイメージファイルとともに読み込まれる、個別設定
#	ファイルを置くディレクトリです。
#	コメントアウトされている場合は、 ~/.quasi88/rc/ になります。

# LCFGDIR = ~/.quasi88/rc/


# ・全体設定ファイル用ディレクトリを設定します
#	起動時に読み込まれる、環境設定ファイルを置くディレクトリです。
#	コメントアウトされている場合は、 ~/.quasi88/ になります。

# GCFGDIR = ~/.quasi88/



# (X11)
# リトルエンディアンの場合の指定
#	ビッグエンディアンマシンの場合は、コメントアウトしましょう。
#	    例えば、IRIX, AIX、Mac OS X(PowerPC) などは、コメントアウトします。
#		    Intel 系の CPUを使った OS などは、このままにしておきます。

X11_LSB_FIRST	= 1


# (X11)
# MIT-SHM を使うかどうかの指定
#	MIT-SHM をサポートしてない場合は、コメントアウトしましょう。

X11_MITSHM	= 1



# (X11)
# long long 型をサポートしていないコンパイラを使う場合、以下をコメントアウト
# してください。 (大抵のコンパイラはサポートしている・・・ハズ)

X11_HAVE_LONG_LONG = 1



# (X11)
# 関数 gettimeofday() を実装していないシステムの場合、以下をコメントアウト
# してください。 (大抵のシステムは実装している・・・ハズ)

X11_HAVE_GETTIMEOFDAY = 1



# (X11)
# XFree86-VidModeExtension を使った全画面表示を組み込まない場合、以下の行を
# コメントアウトして下さい。

X11_VIDMODE		= 1



# (X11)
# FreeBSD にて USB joystick を使用したい場合は、
# 以下のコメントアウトを外して下さい。

# X11_BSD_USB_JOYSTICK	= 1



# (X11/SDL/GTK/MINI)
# QUASI88 ではメニューモードにてスクリーンスナップショット (画面キャプチャ)
# の保存が可能ですが、この時に予め指定した任意のコマンドを実行することが
# できます。
# このコマンド実行機能を無効にしたい場合は、以下をコメントアウトして下さい。

USE_SSS_CMD	= 1



# (X11/SDL/GTK/MINI)
# 以下は、モニターモード (デバッグ用のモード) の機能設定です。
# 通常はモニターモードは使用しないと思われるので、特に変更の必要はありません。
#
#	  MONITOR の行がコメントアウトされている場合は、モニターモードは
#	使用できません。
#
#	  モニターモードにて、GNU Readline を使用する場合、
#	READLINE 行のコメントアウトを外します。
#
#	  モニターモードでの入力待ち時に Ctrl-D を押すと QUASI88 は強制終了
#	してしまいますが、IRIX/AIX では、IGNORE_C_D の行のコメントアウトを
#	外すと、Ctrl-D を押しても終了しなくなります。
#	( IRIX/AIX 以外では、必ずコメントアウトしておいてください。)
#

# USE_MONITOR		= 1

# MONITOR_READLINE	= 1
# MONITOR_IGNORE_C_D	= 1
# MONITOR_USE_LOCALE	= 1



# (X11/SDL/GTK/MINI)
# PC-8801のキーボードバグをエミュレートしたい場合は、
# 以下のコメントアウトを外して下さい。

# USE_KEYBOARD_BUG	= 1



#######################################################################
# サウンド関連の設定
#######################################################################

# (X11/SDL/GTK/MINI)
# MAME/XMAME ベースのサウンド出力を組み込まない場合、以下の行を
# コメントアウトして下さい。

USE_SOUND		= 1



# (X11)
# OS の指定
#	どれか一つを指定してください。
#	generic を選ぶと、サウンドなしになります。
#	そ の 他を選ぶと、サウンドありになる場合もあります。
#	動作確認が取れているのは、FreeBSD と Linux のみです

# FreeBSD
ARCH = freebsd

# Linux
# ARCH = linux

# NetBSD
# ARCH = netbsd

# OpenBSD
# ARCH = openbsd

# Solaris / SunOS
# ARCH = solaris

# QNX Neutrino (QNX4/QNX6)
# ARCH = nto

# OpenStep on NeXT systems
# ARCH = next

# OpenStep on Apple systems (Cocoa)
# ARCH = macosx

# IRIX (with sound using the old AL (version 1) package)
# ARCH = irix

# IRIX (with sound using the al (IRIX 6.x) package)
# ARCH = irix_al

# AIX (with sound, you'll need the UMS and SOM lpp's installed (under AIX4))
# ARCH = aix

# BeOS on Intel
# ARCH = beos

# generic UNIX, no sound
# ARCH = generic



# (X11)
# サウンドデバイスの指定
#	追加したいデバイスがあれば、コメントアウトを外します。
#	いずれも動作確認されていません。

# SOUND_ESOUND		= 1
# SOUND_ALSA		= 1
# SOUND_ARTS_TEIRA	= 1
# SOUND_ARTS_SMOTEK	= 1
# SOUND_SDL		= 1
# SOUND_WAVEOUT		= 1



# (X11/SDL/GTK/MINI)
# QUASI88 ver 0.6.3 以前にて使用していた、古いバージョンの MAME/XMAME の
# サウンド出力を使用したい場合は、以下のコメントアウトを外して下さい。
#	動作に必要なリソースが少なめとなります。

# USE_OLD_MAME_SOUND	= 1



#######################################################################
# fmgen (FM Sound Generator) の設定
#######################################################################

# (X11/SDL/GTK/MINI)
# cisc氏作の、fmgen (FM Sound Generator) を組み込まない場合、以下の行を
# コメントアウトして下さい。

USE_FMGEN	= 1


# 注意！
#	FM Sound Generator は C++ により実装されています。
#	C++ のコンパイラの設定を以下で行なって下さい。
# 
# 	設定すべき項目は、CXX、CXXFLAGS、CXXLIBS および LD の定義です。
# 



#######################################################################
# SDLライブラリの設定
#######################################################################

# (X11/SDL/GTK)
# 以下の場合、SDLライブラリが必要です。
#	・X11_VERSION を選択して、かつ、
#	      サウンドの設定で、「SOUND_SDL = 1」を指定した場合
#	・SDL_VERSION を選択した場合
# ここでは、sdl-config を実行するコマンドを指定してください。
#	通常のOS の場合、sdl-config   のままで大丈夫なはずです。
#	FreeBSD  の場合、sdl12-config などにリネームされていることがあります

SDL_CONFIG	= sdl-config



#######################################################################
# GTKライブラリの設定
#######################################################################

# (GTK)
# GTK_VERSION を選択した場合のみ、以下の設定が必要です。

GTK_CONFIG	= gtk-config



#######################################################################
# コンパイル関連の設定
#######################################################################

# (X11/SDL/GTK/MINI)
# C コンパイラの設定
#	gcc 、 clang などを指定してください。

CC	= cc


# (X11/SDL/GTK/MINI)
# 必要に応じて、コンパイルオプション (最適化など) を指定してください
#	gcc なら、 -fomit-frame-pointer 、 -fstrength-reduce 、 -ffast-math 、
#	-funroll-loops 、 -fstrict-aliasing 等が定番の最適化オプションです。
#
#	コンパイラによっては、char を signed char とみなす指定が必要な場合が
#	あります。PowerPC 系の gcc などがそうですが、この場合、-fsigned-char 
#	を指定します。
#
#	GTK_VERSION を選択した場合で、 clang を使うならば、 -ansi を指定する
#	必要があるかもしれません。

CFLAGS = -O2

# 例えば gcc & PowerPC の場合、以下のコメントアウトを外します。
# CFLAGS += -fsigned-char

# 例えば gcc で最適化をしたい場合、以下のコメントアウトを外します。
# CFLAGS += -fomit-frame-pointer -fstrength-reduce -funroll-loops -ffast-math



# (X11/SDL/GTK/MINI)
# コンパイラによっては、インライン関数を使うことが出来ます。
#	以下から、適切なものを一つだけ指定してください。

# どんなコンパイラでもOK
# USEINLINE	= '-DINLINE=static'

# GCC の場合
USEINLINE	= '-DINLINE=static __inline__'

# Intel C++ コンパイラの場合 (?)
# USEINLINE	= '-DINLINE=static inline'



# (X11)
# X11 関連のディレクトリとライブラリを指定

# 一部のシステム (?)
# X11INC  	= -I/usr/include/X11
# X11LIB  	= -L/usr/lib/X11

# XFree86 の場合 (?)
# X11INC  	= -I/usr/X11R6/include
# X11LIB  	= -L/usr/X11R6/lib

# X.Org の場合
X11INC  	= -I/usr/local/include
X11LIB  	= -L/usr/local/lib



# (X11/SDL/GTK/MINI)
# C++ コンパイラ関連の設定
#	fmgen を組み込まない場合、これらの設定は不要です。
#
#	g++ 、 clang++ などを指定してください。
#	環境によっては、$(CC) と同じ （ gcc 、 clang など） にします。

CXX	 = c++
CXXFLAGS = -O2
CXXLIBS	 = -lstdc++



# (X11/SDL/GTK/MINI)
# リンカの設定
#	C++ コンパイラを使う場合、環境によっては $(CXX) とする必要が
#	あるかもしれません。

LD	= $(CC) -Wl,-s
# LD	= $(CXX) -Wl,-s



#######################################################################
# インストールの設定
#######################################################################

# (X11/SDL/GTK/MINI)
# インストール先ディレクトリの設定
#

BINDIR = /usr/local/bin



###############################################################################
#
# 編集、おつかれさまでした。
# これ以降は、変更不要のはずです。多分・・・
#
###############################################################################

######## 実験あれこれ

# コメントアウトすると、その bpp の X環境において動作不能になる実験

X11_SUPPORT_8BPP	= 1
X11_SUPPORT_16BPP	= 1
X11_SUPPORT_32BPP	= 1

# コメントアウトすると、倍サイズでの表示ができなくなる実験

SUPPORT_DOUBLE		= 1



#######################################################################
#
#######################################################################

# ソースコードディレクトリ

SRCDIR	= ../src


# インクルードディレクトリ

CFLAGS   += -I$(SRCDIR)
CXXFLAGS += -I$(SRCDIR)


#
# バージョン毎の設定
#

ifdef	X11_VERSION

# X11 バージョンでの設定

CFLAGS   += -I$(SRCDIR)/FUNIX -I$(SRCDIR)/X11 $(X11INC) 
CXXFLAGS += -I$(SRCDIR)/FUNIX -I$(SRCDIR)/X11
LIBS     += $(X11LIB) -lX11 -lXext

# X11バージョンの表示まわり

ifdef	X11_MITSHM
CFLAGS += -DMITSHM 
endif

ifdef	X11_VIDMODE
CFLAGS += -DUSE_VIDMODE
LIBS   += -lXxf86vm
endif

ifdef	X11_SUPPORT_8BPP
CFLAGS += -DSUPPORT_8BPP
endif
ifdef	X11_SUPPORT_16BPP
CFLAGS += -DSUPPORT_16BPP
endif
ifdef	X11_SUPPORT_32BPP
CFLAGS += -DSUPPORT_32BPP
endif

# X11バージョンでのジョイスティック設定

ifdef	X11_BSD_USB_JOYSTICK

CFLAGS += -DUSE_BSD_USB_JOYSTICK

ifeq ($(shell test -f /usr/include/usbhid.h && echo have_usbhid), have_usbhid)
CFLAGS += -DHAVE_USBHID_H
LIBS   += -lusbhid
else
ifeq ($(shell test -f /usr/include/libusbhid.h && echo have_libusbhid), have_libusbhid)
CFLAGS += -DHAVE_LIBUSBHID_H
LIBS   += -lusbhid
else
LIBS   += -lusb
endif
endif

endif

# X11バージョンでの雑多な設定

ifdef	X11_LSB_FIRST
CFLAGS += -DLSB_FIRST
endif

ifdef	X11_HAVE_LONG_LONG
CFLAGS += -DHAVE_LONG_LONG
endif

ifdef	X11_HAVE_GETTIMEOFDAY
CFLAGS += -DHAVE_GETTIMEOFDAY
endif

ifdef	HAVE_SELECT
CFLAGS += -DHAVE_SELECT
endif


CFLAGS += -DQUASI88_X11



else
ifdef	SDL_VERSION

# SDLバージョンでの設定

CFLAGS   += -I$(SRCDIR)/FUNIX -I$(SRCDIR)/SDL `$(SDL_CONFIG) --cflags`
CXXFLAGS += -I$(SRCDIR)/FUNIX -I$(SRCDIR)/SDL `$(SDL_CONFIG) --cflags`
LIBS     +=                                   `$(SDL_CONFIG) --libs`

CFLAGS += -DQUASI88_SDL

else
ifdef	GTK_VERSION

# GTKバージョンでの設定

CFLAGS   += -I$(SRCDIR)/FUNIX -I$(SRCDIR)/GTK `$(GTK_CONFIG) --cflags`
CXXFLAGS += -I$(SRCDIR)/FUNIX -I$(SRCDIR)/GTK `$(GTK_CONFIG) --cflags`
LIBS     +=                                   `$(GTK_CONFIG) --libs`

CFLAGS += -DQUASI88_GTK

else
ifdef	MINI_VERSION

# MINIバージョンでの設定

CFLAGS   += -I$(SRCDIR)/FDUMMY -I$(SRCDIR)/MINI
CXXFLAGS += -I$(SRCDIR)/FDUMMY -I$(SRCDIR)/MINI

CFLAGS += -DQUASI88_MINI

endif
endif
endif
endif



# モニターモード有効時の設定


ifdef	USE_MONITOR
CFLAGS += -DUSE_MONITOR

ifdef	MONITOR_READLINE
CFLAGS += -DUSE_GNU_READLINE
LIBS   += -lreadline -lncurses
endif

ifdef	MONITOR_IGNORE_C_D
CFLAGS += -DIGNORE_CTRL_D
endif

ifdef	MONITOR_USE_LOCALE
CFLAGS += -DUSE_LOCALE
endif

endif


# その他

ifdef	SUPPORT_DOUBLE
CFLAGS += -DSUPPORT_DOUBLE
endif

ifdef	USE_SSS_CMD
CFLAGS += -DUSE_SSS_CMD
endif

ifdef	USE_KEYBOARD_BUG
CFLAGS += -DUSE_KEYBOARD_BUG
endif





#######################################################################
# サウンドが有効になっている場合の各種定義
#	ここでは、
#		SOUND_OBJS
#		SOUND_LIBS
#		SOUND_CFLAGS
#	が定義される。
#######################################################################
ifdef	USE_SOUND

#
# サウンド有効時の、追加オブジェクト ( OS依存部 + 共用部 )
#

#### ディレクトリ

ifdef	USE_OLD_MAME_SOUND
SNDDRV_DIR	= snddrv-old
else
SNDDRV_DIR	= snddrv
endif

SD_Q88_DIR	= $(SNDDRV_DIR)/quasi88
SD_X11_DIR	= $(SNDDRV_DIR)/quasi88/X11
SD_SDL_DIR	= $(SNDDRV_DIR)/quasi88/SDL

XM_SRC_DIR	= $(SNDDRV_DIR)/src
XM_SOUND_DIR	= $(SNDDRV_DIR)/src/sound
XM_UNIX_DIR	= $(SNDDRV_DIR)/src/unix
XM_SYSDEP_DIR	= $(SNDDRV_DIR)/src/unix/sysdep
XM_DSP_DIR	= $(SNDDRV_DIR)/src/unix/sysdep/dsp-drivers
XM_MIXER_DIR	= $(SNDDRV_DIR)/src/unix/sysdep/mixer-drivers


#### オブジェクト

SOUND_OBJS_BASE	= $(SD_Q88_DIR)/mame-quasi88.o	\
		  $(SD_Q88_DIR)/beepintf.o	\
		  $(SD_Q88_DIR)/beep.o		\
		  $(XM_SRC_DIR)/driver.o	\
		  $(XM_SRC_DIR)/restrack.o	\
		  $(XM_SRC_DIR)/sound.o		\
		  $(XM_SRC_DIR)/sndintrf.o	\
		  $(XM_SRC_DIR)/streams.o	\
		  $(XM_SOUND_DIR)/flt_vol.o	\
		  $(XM_SOUND_DIR)/flt_rc.o	\
		  $(XM_SOUND_DIR)/wavwrite.o	\
		  $(XM_SOUND_DIR)/2203intf.o	\
		  $(XM_SOUND_DIR)/2608intf.o	\
		  $(XM_SOUND_DIR)/ay8910.o	\
		  $(XM_SOUND_DIR)/fm.o		\
		  $(XM_SOUND_DIR)/ymdeltat.o	\
		  $(XM_SOUND_DIR)/samples.o

SOUND_OBJS_UNIX	= $(XM_UNIX_DIR)/sound.o		\
		  $(XM_SYSDEP_DIR)/rc.o			\
		  $(XM_SYSDEP_DIR)/misc.o		\
		  $(XM_SYSDEP_DIR)/plugin_manager.o	\
		  $(XM_SYSDEP_DIR)/sysdep_dsp.o		\
		  $(XM_SYSDEP_DIR)/sysdep_mixer.o	\
		  $(XM_SYSDEP_DIR)/sysdep_sound_stream.o

SOUND_OBJS.linux   = $(XM_DSP_DIR)/oss.o $(XM_MIXER_DIR)/oss.o
SOUND_OBJS.freebsd = $(XM_DSP_DIR)/oss.o $(XM_MIXER_DIR)/oss.o
SOUND_OBJS.netbsd  = $(XM_DSP_DIR)/netbsd.o
#SOUND_OBJS.openbsd = $(XM_DSP_DIR)/oss.o $(XM_MIXER_DIR)/oss.o
SOUND_OBJS.openbsd = $(XM_DSP_DIR)/netbsd.o 
SOUND_OBJS.solaris = $(XM_DSP_DIR)/solaris.o $(XM_MIXER_DIR)/solaris.o
SOUND_OBJS.next    = $(XM_DSP_DIR)/soundkit.o
SOUND_OBJS.macosx  = $(XM_DSP_DIR)/coreaudio.o
SOUND_OBJS.nto     = $(XM_DSP_DIR)/io-audio.o
SOUND_OBJS.irix    = $(XM_DSP_DIR)/irix.o
SOUND_OBJS.irix_al = $(XM_DSP_DIR)/irix_al.o
SOUND_OBJS.beos    =
SOUND_OBJS.generic =
#these need to be converted to plugins first
#SOUND_OBJS.aix     = $(XM_DSP_DIR)/aix.o


#### Cフラグ

CFLAGS   += -DUSE_SOUND
CXXFLAGS += -DUSE_SOUND

SOUND_CFLAGS      = -DPI=M_PI -I$(SRCDIR)/$(SNDDRV_DIR) -I$(SRCDIR)/$(SD_Q88_DIR) -I$(SRCDIR)/$(XM_SRC_DIR) -I$(SRCDIR)/$(XM_SOUND_DIR)
SOUND_CXXFLAGS    =           -I$(SRCDIR)/$(SNDDRV_DIR) -I$(SRCDIR)/$(SD_Q88_DIR) -I$(SRCDIR)/$(XM_SRC_DIR) -I$(SRCDIR)/$(XM_SOUND_DIR)

SOUND_CFLAGS_UNIX = -I$(SRCDIR)/$(SD_X11_DIR) -I$(SRCDIR)/$(XM_UNIX_DIR) -I$(SRCDIR)/$(XM_SYSDEP_DIR) -I$(SRCDIR)/$(XM_DSP_DIR) -I$(SRCDIR)/$(XM_MIXER_DIR)


#### バージョン毎の設定

ifdef	X11_VERSION

#
# X11 バージョンでのサウンド設定
#

SOUND_OBJS	= $(SOUND_OBJS_BASE)		\
		  $(SD_X11_DIR)/audio.o		\
		  $(SOUND_OBJS_UNIX)		\
		  $(SOUND_OBJS.$(ARCH))


#
# サウンド有効時のコンパイルオプション
#	-DHAVE_SNPRINTF, -DHAVE_VSNPRINTF は不要のはず…

CFLAGS.linux      = -DSYSDEP_DSP_OSS -DSYSDEP_MIXER_OSS -DHAVE_SNPRINTF -DHAVE_VSNPRINTF
CFLAGS.freebsd    = -DSYSDEP_DSP_OSS -DSYSDEP_MIXER_OSS -DHAVE_SNPRINTF -DHAVE_VSNPRINTF
CFLAGS.netbsd     = -DSYSDEP_DSP_NETBSD -DHAVE_SNPRINTF -DHAVE_VSNPRINTF
CFLAGS.openbsd    = -DSYSDEP_DSP_NETBSD -DHAVE_SNPRINTF -DHAVE_VSNPRINTF
CFLAGS.solaris    = -DSYSDEP_DSP_SOLARIS -DSYSDEP_MIXER_SOLARIS
CFLAGS.next       = -DSYSDEP_DSP_SOUNDKIT -DBSD43
CFLAGS.macosx     = -DSYSDEP_DSP_COREAUDIO
CFLAGS.nto        = -DSYSDEP_DSP_ALSA -DSYSDEP_MIXER_ALSA
CFLAGS.irix       = -DSYSDEP_DSP_IRIX -DHAVE_SNPRINTF
CFLAGS.irix_al    = -DSYSDEP_DSP_IRIX -DHAVE_SNPRINTF
CFLAGS.beos       = `$(SDL_CONFIG) --cflags` -DSYSDEP_DSP_SDL
CFLAGS.generic    =
#these need to be converted to plugins first
#CFLAGS.aix        = -DSYSDEP_DSP_AIX -I/usr/include/UMS -I/usr/lpp/som/include

SOUND_CFLAGS	+= -D__ARCH_$(ARCH) $(CFLAGS.$(ARCH)) $(SOUND_CFLAGS_UNIX)


#
# サウンド有効時のライブラリ指定
#	関係無いのも含まれていそう………

LIBS.solaris       = -lnsl -lsocket
LIBS.irix          = -laudio
LIBS.irix_al       = -laudio
LIBS.aix           = -lUMSobj
LIBS.next	   = -framework SoundKit
LIBS.macosx	   = -framework CoreAudio
#LIBS.macosx	   = -framework AudioUnit -framework CoreServices
#LIBS.openbsd       = -lossaudio
LIBS.nto	   = -lsocket -lasound
LIBS.beos          = `$(SDL_CONFIG) --libs`

SOUND_LIBS	= -lm $(LIBS.$(ARCH))


#
# 追加サウンドデバイス指定時の、追加設定
#

ifdef SOUND_ESOUND
SOUND_CFLAGS += -DSYSDEP_DSP_ESOUND `esd-config --cflags`
SOUND_LIBS   += `esd-config --libs`
SOUND_OBJS   += $(XM_DSP_DIR)/esound.o
endif

ifdef SOUND_ALSA
SOUND_CFLAGS += -DSYSDEP_DSP_ALSA -DSYSDEP_MIXER_ALSA
SOUND_LIBS   += -lasound
SOUND_OBJS   += $(XM_DSP_DIR)/alsa.o $(XM_MIXER_DIR)/alsa.o
endif

ifdef SOUND_ARTS_TEIRA
SOUND_CFLAGS += -DSYSDEP_DSP_ARTS_TEIRA `artsc-config --cflags`
SOUND_LIBS   += `artsc-config --libs`
SOUND_OBJS   += $(XM_DSP_DIR)/artssound.o
endif

ifdef SOUND_ARTS_SMOTEK
SOUND_CFLAGS += -DSYSDEP_DSP_ARTS_SMOTEK `artsc-config --cflags`
SOUND_LIBS   += `artsc-config --libs`
SOUND_OBJS   += $(XM_DSP_DIR)/arts.o
endif

ifdef SOUND_SDL
SOUND_CFLAGS += -DSYSDEP_DSP_SDL `$(SDL_CONFIG) --cflags`
SOUND_LIBS   += `$(SDL_CONFIG) --libs`
SOUND_OBJS   += $(XM_DSP_DIR)/sdl.o
endif

ifdef SOUND_WAVEOUT
SOUND_CFLAGS += -DSYSDEP_DSP_WAVEOUT
SOUND_OBJS   += $(XM_DSP_DIR)/waveout.o
endif



else
ifdef	SDL_VERSION

#
# SDL バージョンでのサウンド設定
#

SOUND_OBJS	= $(SOUND_OBJS_BASE)		\
		  $(SD_SDL_DIR)/audio.o		\
		  $(SD_SDL_DIR)/sdl.o

SOUND_CFLAGS	+= -I$(SRCDIR)/$(SD_SDL_DIR) -DSYSDEP_DSP_SDL
SOUND_CXXFLAGS	+= -I$(SRCDIR)/$(SD_SDL_DIR)
SOUND_LIBS	= -lm

else
ifdef	GTK_VERSION

#
# GTK バージョンでのサウンド設定
#	SDL にて鳴らすことにする

SOUND_OBJS	= $(SOUND_OBJS_BASE)		\
		  $(SD_SDL_DIR)/audio.o		\
		  $(SD_SDL_DIR)/sdl.o
SOUND_CFLAGS	+= -I$(SRCDIR)/$(SD_SDL_DIR) -DSYSDEP_DSP_SDL `$(SDL_CONFIG) --cflags`
SOUND_CXXFLAGS	+= -I$(SRCDIR)/$(SD_SDL_DIR)
SOUND_LIBS	= `$(SDL_CONFIG) --libs` -lm


#	OSSで鳴らそうとしたが、ノイズだらけでうまく鳴らない……

#SOUND_OBJS	= $(SOUND_OBJS_BASE)		\
#		  $(SD_X11_DIR)/audio.o		\
#		  $(SOUND_OBJS_UNIX)		\
#		  $(SOUND_OBJS.$(ARCH))
#SOUND_CFLAGS	+= -D__ARCH_$(ARCH) -DSYSDEP_DSP_OSS -DSYSDEP_MIXER_OSS -DHAVE_SNPRINTF -DHAVE_VSNPRINTF $(SOUND_CFLAGS_UNIX)
#SOUND_CXXFLAGS	+= -D__ARCH_$(ARCH) -DSYSDEP_DSP_OSS -DSYSDEP_MIXER_OSS -DHAVE_SNPRINTF -DHAVE_VSNPRINTF $(SOUND_CFLAGS_UNIX)
#SOUND_LIBS	= -lm

else
ifdef	MINI_VERSION

#
# MINI バージョンでのサウンド設定
#	コンパイル検証のみ。音は出ない

SOUND_OBJS	= $(SOUND_OBJS_BASE)	\
		  MINI/audio.o
#SOUND_CFLAGS	+=
#SOUND_CXXFLAGS	+=
SOUND_LIBS	= -lm

endif
endif
endif
endif




#### fmgen 指定時の設定

ifdef	USE_FMGEN

FMGEN_DIR	= fmgen
FMGEN_OBJ	= $(SD_Q88_DIR)/2203fmgen.o	\
		  $(SD_Q88_DIR)/2608fmgen.o	\
		  $(FMGEN_DIR)/fmgen.o		\
		  $(FMGEN_DIR)/fmtimer.o	\
		  $(FMGEN_DIR)/opna.o		\
		  $(FMGEN_DIR)/psg.o

CFLAGS		+= -DUSE_FMGEN
CXXFLAGS	+= -DUSE_FMGEN

SOUND_CFLAGS	+= -I$(SRCDIR)/$(FMGEN_DIR)
SOUND_CXXFLAGS	+= -I$(SRCDIR)/$(FMGEN_DIR)

SOUND_OBJS	+= $(FMGEN_OBJ)

SOUND_LIBS	+= $(CXXLIBS)

endif

endif



#######################################################################
#
#######################################################################


ifdef	X11_VERSION
PROGRAM = quasi88-x11
else
ifdef	SDL_VERSION
PROGRAM = quasi88-sdl
else
ifdef	GTK_VERSION
PROGRAM = quasi88-gtk
else
ifdef	MINI_VERSION
PROGRAM = quasi88-mini
endif
endif
endif
endif



ifdef	X11_VERSION
OBJECT = X11/graph.o X11/wait.o X11/event.o X11/joystick.o X11/main.o FUNIX/file-op.o
else
ifdef	SDL_VERSION
OBJECT = SDL/graph.o SDL/wait.o SDL/event.o SDL/main.o FUNIX/file-op.o
else
ifdef	GTK_VERSION
OBJECT = GTK/graph.o GTK/wait.o GTK/event.o GTK/main.o GTK/menubar.o FUNIX/file-op.o
else
ifdef	MINI_VERSION
OBJECT = MINI/graph.o MINI/wait.o MINI/event.o MINI/main.o FDUMMY/file-op.o
endif
endif
endif
endif



OBJECT += quasi88.o emu.o memory.o status.o getconf.o \
	  pc88main.o crtcdmac.o soundbd.o pio.o screen.o intr.o \
	  pc88sub.o fdc.o image.o monitor.o basic.o \
	  menu.o menu-screen.o q8tk.o q8tk-glib.o suspend.o \
	  keyboard.o romaji.o pause.o \
	  z80.o z80-debug.o snapshot.o \
	  screen-8bpp.o screen-16bpp.o screen-32bpp.o screen-snapshot.o \
	  $(SOUND_OBJS)

CFLAGS   += -DROM_DIR='"$(ROMDIR)"' -DDISK_DIR='"$(DISKDIR)"' \
	    -DTAPE_DIR='"$(TAPEDIR)"' -DSNAP_DIR='"$(SNAPDIR)"' \
	    -DSTATE_DIR='"$(STATEDIR)"' -DL_CFG_DIR='"$(LCFGDIR)"' \
	    -DG_CFG_DIR='"$(GCFGDIR)"' $(USEINLINE) -DCLIB_DECL= 
CXXFLAGS += -DCLIB_DECL= 

LIBS   += $(SOUND_LIBS)

###

ifdef	X11_VERSION
OBJDIR		= obj-x11
OBJDIRS		+= $(OBJDIR) $(OBJDIR)/X11 $(OBJDIR)/FUNIX
else
ifdef	SDL_VERSION
OBJDIR		= obj-sdl
OBJDIRS		+= $(OBJDIR) $(OBJDIR)/SDL $(OBJDIR)/FUNIX
else
ifdef	GTK_VERSION
OBJDIR		= obj-gtk
OBJDIRS		+= $(OBJDIR) $(OBJDIR)/GTK $(OBJDIR)/FUNIX
else
ifdef	MINI_VERSION
OBJDIR		= obj-mini
OBJDIRS		+= $(OBJDIR) $(OBJDIR)/MINI $(OBJDIR)/FDUMMY
endif
endif
endif
endif

OBJDIRS		+= $(addprefix $(OBJDIR)/, \
		  	$(SNDDRV_DIR) $(FMGEN_DIR) \
		  	$(SD_Q88_DIR) $(SD_X11_DIR) $(SD_SDL_DIR) \
			$(XM_SRC_DIR) $(XM_SOUND_DIR) $(XM_UNIX_DIR) \
			$(XM_SYSDEP_DIR) $(XM_DSP_DIR) $(XM_MIXER_DIR))

OBJECTS		= $(addprefix $(OBJDIR)/, $(OBJECT))



###

all:		$(OBJDIRS) $(PROGRAM)

$(OBJDIRS):
		-mkdir $@

$(PROGRAM):	$(OBJECTS)
		$(LD) $(OBJECTS) $(LIBS) -o $(PROGRAM) 


$(OBJDIR)/MINI/audio.o: $(SRCDIR)/MINI/audio.c
		$(CC) $(CFLAGS) $(SOUND_CFLAGS) $(DEBUG_CFLAGS) -o $@ -c $<


$(OBJDIR)/$(SNDDRV_DIR)/%.o: $(SRCDIR)/$(SNDDRV_DIR)/%.c
		$(CC) $(CFLAGS) $(SOUND_CFLAGS) $(DEBUG_CFLAGS) -o $@ -c $<

$(OBJDIR)/$(SNDDRV_DIR)/%.o: $(SRCDIR)/$(SNDDRV_DIR)/%.m
		$(CC) $(CFLAGS) $(SOUND_CFLAGS) $(DEBUG_CFLAGS) -o $@ -c $<

$(OBJDIR)/$(SNDDRV_DIR)/%.o: $(SRCDIR)/$(SNDDRV_DIR)/%.cpp
		$(CXX) $(CXXFLAGS) $(SOUND_CXXFLAGS) $(DEBUG_CXXFLAGS) -o $@ -c $<

$(OBJDIR)/$(FMGEN_DIR)/%.o: $(SRCDIR)/$(FMGEN_DIR)/%.cpp
		$(CXX) $(CXXFLAGS) $(SOUND_CXXFLAGS) $(DEBUG_CXXFLAGS) -o $@ -c $<


$(OBJDIR)/%.o: $(SRCDIR)/%.c
		$(CC) $(CFLAGS) $(DEBUG_CFLAGS) -o $@ -c $<

$(OBJDIR)/%.o: $(SRCDIR)/%.m
		$(CC) $(CFLAGS) $(DEBUG_CFLAGS) -o $@ -c $<

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
		$(CXX) $(CXXFLAGS) $(DEBUG_CXXFLAGS) -o $@ -c $<


$(OBJDIR)/%.s: $(SRCDIR)/%.c
		$(CC) $(CFLAGS) $(SOUND_CFLAGS) $(DEBUG_CFLAGS) -o $@ -S $<


clean:
		rm -rf $(OBJDIR) $(PROGRAM) $(PROGRAM).core

debug:
		@echo Makefile Debug Target is here.


#
# インストールに関する設定
#

install:
		@echo installing binaries under $(BINDIR)...
		@cp $(PROGRAM) $(BINDIR)/


#
#
#


#
# ファイルの依存関係の更新
#
#	make depend をすれば、 Makefile.depend が生成(更新)されます。
#	(C コンパイラの設定で gcc を指定しておく必要があります)
#

SOURCES		= $(subst $(OBJDIR)/, $(SRCDIR)/, $(OBJECTS))
SOURCES		:= $(patsubst %.o, %.c, $(SOURCES))
SOURCES		:= $(patsubst $(SRCDIR)/fmgen/%.c, $(SRCDIR)/fmgen/%.cpp, $(SOURCES))
SOURCES		:= $(subst $(SRCDIR)/snddrv/quasi88/2203fmgen.c, $(SRCDIR)/snddrv/quasi88/2203fmgen.cpp, $(SOURCES))
SOURCES		:= $(subst $(SRCDIR)/snddrv/quasi88/2608fmgen.c, $(SRCDIR)/snddrv/quasi88/2608fmgen.cpp, $(SOURCES))

TMP_FILE = Makefile.tmp
DEP_FILE = Makefile.depend

depend:
		-@$(CC) -MM $(CFLAGS) $(SOUND_CFLAGS) $(SOURCES) > $(TMP_FILE)
		-@echo '# This file is generated by gcc' >  $(DEP_FILE)
		-@echo '#   Do not edit !'               >> $(DEP_FILE)
		-@echo                                   >> $(DEP_FILE)
		-@perl -ane '$$S="$(SRCDIR)"; $$O="$(OBJDIR)";  if (/:/) { @L = split(); $$Z = substr( $$L[1], 0, rindex( $$L[1], "/" ) ); $$Z =~ s/^$$S/$$O/; $$L[0] = $$Z . "/" . $$L[0]; $$_ = join( " ", @L ); print "$$_\n"; } else { print "$$_"; }' $(TMP_FILE) >> $(DEP_FILE)
		-@rm -f $(TMP_FILE)


-include $(DEP_FILE)
