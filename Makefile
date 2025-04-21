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

#######################################################################
# 基本設定
#######################################################################


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



# QUASI88 ではメニューモードにてスクリーンスナップショット (画面キャプチャ)
# の保存が可能ですが、この時に予め指定した任意のコマンドを実行することが
# できます。
# このコマンド実行機能を無効にしたい場合は、以下をコメントアウトして下さい。

USE_SSS_CMD	= 1



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



# PC-8801のキーボードバグをエミュレートしたい場合は、
# 以下のコメントアウトを外して下さい。

# USE_KEYBOARD_BUG	= 1



#######################################################################
# サウンド関連の設定
#######################################################################

# MAME/XMAME ベースのサウンド出力を組み込まない場合、以下の行を
# コメントアウトして下さい。

USE_SOUND		= 1



# QUASI88 ver 0.6.3 以前にて使用していた、古いバージョンの MAME/XMAME の
# サウンド出力を使用したい場合は、以下のコメントアウトを外して下さい。
#	動作に必要なリソースが少なめとなります。

USE_OLD_MAME_SOUND	= 1



#######################################################################
# fmgen (FM Sound Generator) の設定
#######################################################################

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
# SDL2ライブラリの設定
#######################################################################

# sdl2-config を実行するコマンドを指定してください。

SDL2_CONFIG	= sdl2-config



#######################################################################
# コンパイル関連の設定
#######################################################################

# C コンパイラの設定
#	gcc 、 clang などを指定してください。

CC	= cc


# 必要に応じて、コンパイルオプション (最適化など) を指定してください
#	gcc なら、 -fomit-frame-pointer 、 -fstrength-reduce 、 -ffast-math 、
#	-funroll-loops 、 -fstrict-aliasing 等が定番の最適化オプションです。
#
#	コンパイラによっては、char を signed char とみなす指定が必要な場合が
#	あります。PowerPC 系の gcc などがそうですが、この場合、-fsigned-char 
#	を指定します。

CFLAGS = -O2

# 例えば gcc & PowerPC の場合、以下のコメントアウトを外します。
# CFLAGS += -fsigned-char

# 例えば gcc で最適化をしたい場合、以下のコメントアウトを外します。
# CFLAGS += -fomit-frame-pointer -fstrength-reduce -funroll-loops -ffast-math



# コンパイラによっては、インライン関数を使うことが出来ます。
#	以下から、適切なものを一つだけ指定してください。

# どんなコンパイラでもOK
# USEINLINE	= '-DINLINE=static'

# GCC の場合
USEINLINE	= '-DINLINE=static __inline__'

# Intel C++ コンパイラの場合 (?)
# USEINLINE	= '-DINLINE=static inline'



# C++ コンパイラ関連の設定
#	fmgen を組み込まない場合、これらの設定は不要です。
#
#	g++ 、 clang++ などを指定してください。
#	環境によっては、$(CC) と同じ （ gcc 、 clang など） にします。

CXX	 = c++
CXXFLAGS = -O2
CXXLIBS	 = -lstdc++



# リンカの設定
#	C++ コンパイラを使う場合、環境によっては $(CXX) とする必要が
#	あるかもしれません。

LD	= $(CC) -Wl,-s
# LD	= $(CXX) -Wl,-s



#######################################################################
# インストールの設定
#######################################################################

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

# コメントアウトすると、倍サイズでの表示ができなくなる実験

SUPPORT_DOUBLE		= 1



#######################################################################
#
#######################################################################

# ソースコードディレクトリ

SRCDIR	= src


# インクルードディレクトリ

CFLAGS   += -I$(SRCDIR)
CXXFLAGS += -I$(SRCDIR)


#
# SDL2バージョンでの設定
#

CFLAGS   += -I$(SRCDIR)/FUNIX -I$(SRCDIR)/SDL2 `$(SDL2_CONFIG) --cflags`
CXXFLAGS += -I$(SRCDIR)/FUNIX -I$(SRCDIR)/SDL2 `$(SDL2_CONFIG) --cflags`
LIBS     +=                                    `$(SDL2_CONFIG) --libs`

CFLAGS += -DQUASI88_SDL2



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
SD_SDL_DIR	= $(SNDDRV_DIR)/quasi88/SDL

XM_SRC_DIR	= $(SNDDRV_DIR)/src
XM_SOUND_DIR	= $(SNDDRV_DIR)/src/sound


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


#### Cフラグ

CFLAGS   += -DUSE_SOUND
CXXFLAGS += -DUSE_SOUND

SOUND_CFLAGS      = -DPI=M_PI -I$(SRCDIR)/$(SNDDRV_DIR) -I$(SRCDIR)/$(SD_Q88_DIR) -I$(SRCDIR)/$(XM_SRC_DIR) -I$(SRCDIR)/$(XM_SOUND_DIR)
SOUND_CXXFLAGS    =           -I$(SRCDIR)/$(SNDDRV_DIR) -I$(SRCDIR)/$(SD_Q88_DIR) -I$(SRCDIR)/$(XM_SRC_DIR) -I$(SRCDIR)/$(XM_SOUND_DIR)


#
# SDL2 バージョンでのサウンド設定
#

SOUND_OBJS	= $(SOUND_OBJS_BASE)		\
		  $(SD_SDL_DIR)/audio.o		\
		  $(SD_SDL_DIR)/sdl.o

SOUND_CFLAGS	+= -I$(SRCDIR)/$(SD_SDL_DIR) -DSYSDEP_DSP_SDL
SOUND_CXXFLAGS	+= -I$(SRCDIR)/$(SD_SDL_DIR)
SOUND_LIBS	= -lm




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


PROGRAM = quasi88

OBJECT = SDL2/graph.o SDL2/wait.o SDL2/event.o SDL2/main.o FUNIX/file-op.o

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

OBJDIR		= obj

OBJDIRS		+= $(OBJDIR) $(OBJDIR)/SDL2 $(OBJDIR)/FUNIX
OBJDIRS		+= $(addprefix $(OBJDIR)/, \
		  	$(SNDDRV_DIR) $(FMGEN_DIR) \
		  	$(SD_Q88_DIR) $(SD_SDL_DIR) \
			$(XM_SRC_DIR) $(XM_SOUND_DIR))

OBJECTS		= $(addprefix $(OBJDIR)/, $(OBJECT))



###

all:		$(OBJDIRS) $(PROGRAM)

$(OBJDIRS):
		-mkdir $@

$(PROGRAM):	$(OBJECTS)
		$(LD) $(OBJECTS) $(LIBS) -o $(PROGRAM) 


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
