###############################################################################
#
# Makefile for quasi88/UNIX (FreeBSD, Linux, Mac OS X and so on...)
#
#	ɬ����GNU make ��ɬ�פǤ���
#
#			    ���� Makefile �κ����ˤ����äƤ� XMAME �� 
#			    makefile.unix��src/unix/unix.mak �򻲹ͤˤ��ޤ�����
#			    ����ѥ����Ϣ������ˤĤ��Ƥϡ��嵭�Υե������
#			    ���ܤ���Ƥ��륳���Ȥ���Ω�Ĥ��⤷��ޤ���
###############################################################################

# X11�ǡ�SDL�ǤΤ����줫�����ꤷ�ޤ�
#	X11�Ǥξ��ϡ���X11_VERSION�װʳ��ιԤ򥳥��ȥ����Ȥ��Ƥ���������
#	SDL�Ǥξ��ϡ���SDL_VERSION�װʳ��ιԤ򥳥��ȥ����Ȥ��Ƥ���������
#	GTK�Ǥξ��ϡ���GTK_VERSION�װʳ��ιԤ򥳥��ȥ����Ȥ��Ƥ���������
#	( GTK�Ǥϼ¸���Ǥ���GTK�Ǥǥ�����ɤ��Ĥ餹�ˤϡ�SDL ��ɬ�פǤ� )

# X11_VERSION	= 1
SDL_VERSION	= 1
# GTK_VERSION	= 1


#######################################################################
# ��������
#######################################################################


# ROM�ѥǥ��쥯�ȥ�����ꤷ�ޤ�
#	BASIC �� ROM���᡼�� �򸡺�����ǥ��쥯�ȥ�Ǥ���
#	���ץ����Ǥλ���⡢�Ķ��ѿ��������̵�����ˡ����������ꤷ��
#	�ǥ��쥯�ȥ꤬���Ѥ���ޤ���
#	 ~/ �ϡ�QUASI88�ε�ư���˥ۡ���ǥ��쥯�ȥ��$HOME�ˤ�Ÿ������ޤ���

ROMDIR	= ~/quasi88/rom/


# DISK�ѥǥ��쥯�ȥ�����ꤷ�ޤ�
#	��ư���ˡ������ǻ��ꤷ�����᡼���ե�����򳫤��ݤˡ�
#	���Υե�����򸡺�����ǥ��쥯�ȥ�Ǥ���
#	���ץ����Ǥλ���⡢�Ķ��ѿ��������̵�����ˡ����������ꤷ��
#	�ǥ��쥯�ȥ꤬���Ѥ���ޤ���
#	 ~/ �ϡ�QUASI88�ε�ư���˥ۡ���ǥ��쥯�ȥ��$HOME�ˤ�Ÿ������ޤ���

DISKDIR	= ~/quasi88/disk/


# TAPE�ѥǥ��쥯�ȥ�����ꤷ�ޤ�
#	TAPE �Υ��᡼�����֤��ǥ��쥯�ȥ�Ǥ���
#	���ץ����Ǥλ���⡢�Ķ��ѿ��������̵�����ˡ����������ꤷ��
#	�ǥ��쥯�ȥ꤬���Ѥ���ޤ���
#	 ~/ �ϡ�QUASI88�ε�ư���˥ۡ���ǥ��쥯�ȥ��$HOME�ˤ�Ÿ������ޤ���

TAPEDIR	= ~/quasi88/tape/


# (X11)
# ��ȥ륨��ǥ�����ξ��λ���
#	�ӥå�����ǥ�����ޥ���ξ��ϡ������ȥ����Ȥ��ޤ��礦��
#	    �㤨�С�IRIX, AIX��Mac OS X(PowerPC) �ʤɤϡ������ȥ����Ȥ��ޤ���
#		    Intel �Ϥ� CPU��Ȥä� OS �ʤɤϡ����Τޤޤˤ��Ƥ����ޤ���

X11_LSB_FIRST	= 1


# (X11)
# MIT-SHM ��Ȥ����ɤ����λ���
#	MIT-SHM �򥵥ݡ��Ȥ��Ƥʤ����ϡ������ȥ����Ȥ��ޤ��礦��

X11_MITSHM	= 1



# (X11)
# long long ���򥵥ݡ��Ȥ��Ƥ��ʤ�����ѥ����Ȥ���硢�ʲ��򥳥��ȥ�����
# ���Ƥ��������� (����Υ���ѥ���ϥ��ݡ��Ȥ��Ƥ��롦�����ϥ�)

X11_HAVE_LONG_LONG = 1



# (X11)
# �ؿ� gettimeofday() ��������Ƥ��ʤ������ƥ�ξ�硢�ʲ��򥳥��ȥ�����
# ���Ƥ��������� (����Υ����ƥ�ϼ������Ƥ��롦�����ϥ�)

X11_HAVE_GETTIMEOFDAY = 1



# (X11)
# ���祤���ƥ��å����Ѥ�̵ͭ
#	�ʲ��Τ����줫�ΰ�ĤΤߡ������Ȥ򳰤����Ȥ�����ޤ���
#
#	 ��X11_JOYSTICK = joy_nothing�פιԤΥ����ȥ����Ȥ򳰤��ȡ�
#	���祤���ƥ��å��ϥ��ݡ��Ȥ���ޤ���
#
#	 ��X11_JOYSTICK = joy_sdl�פιԤΥ����ȥ����Ȥ򳰤��ȡ�
#	SDL�饤�֥��ˤ�른�祤���ƥ��å���ǽ���Ȥ߹��ޤ�ޤ���
#	( Linux �� FreeBSD��ư���ǧ�Ѥߡ��ºݤ˥��祤���ƥ��å����Ȥ��뤫
#	  �ɤ����ϡ�SDL�饤�֥��˰�¸���ޤ���)
#
#	 ��X11_JOYSTICK = joy_linux_usb�פιԤΥ����ȥ����Ȥ򳰤��ȡ�
#	Linux �ˤ� USB joystick �����ѤǤ��ޤ���
#	( �Ķ��ˤ�äƤϡ����ѤǤ��ʤ����⤷��ޤ��� )
#
#	 ��X11_JOYSTICK = joy_bsd_usb�פιԤΥ����ȥ����Ȥ򳰤��ȡ�
#	FreeBSD �ˤ� USB joystick �����ѤǤ��ޤ���
#	( �Ķ��ˤ�äƤϡ�����ѥ��뤹��Ǥ��ʤ����⤷��ޤ��� )

X11_JOYSTICK	= joy_nothing
# X11_JOYSTICK	= joy_sdl
# X11_JOYSTICK	= joy_linux_usb
# X11_JOYSTICK	= joy_bsd_usb



# QUASI88 �Ǥϥ�˥塼�⡼�ɤˤƥ����꡼�󥹥ʥåץ���å� (���̥���ץ���)
# ����¸����ǽ�Ǥ��������λ���ͽ����ꤷ��Ǥ�դΥ��ޥ�ɤ�¹Ԥ��뤳�Ȥ�
# �Ǥ��ޤ���
# ���Υ��ޥ�ɼ¹Ե�ǽ��̵���ˤ��������ϡ��ʲ��򥳥��ȥ����Ȥ��Ʋ�������

USE_SSS_CMD	= 1



# �ʲ��ϡ���˥����⡼�� (�ǥХå��ѤΥ⡼��) �ε�ǽ����Ǥ���
# �̾�ϥ�˥����⡼�ɤϻ��Ѥ��ʤ��Ȼפ���Τǡ��ä��ѹ���ɬ�פϤ���ޤ���
#
#	  MONITOR �ιԤ������ȥ����Ȥ���Ƥ�����ϡ���˥����⡼�ɤ�
#	���ѤǤ��ޤ���
#
#	  ��˥����⡼�ɤˤơ�GNU Readline ����Ѥ����硢
#	READLINE �ԤΥ����ȥ����Ȥ򳰤��ޤ���
#
#	  ��˥����⡼�ɤǤ������Ԥ����� Ctrl-D �򲡤��� QUASI88 �϶�����λ
#	���Ƥ��ޤ��ޤ�����IRIX/AIX �Ǥϡ�IGNORE_C_D �ιԤΥ����ȥ����Ȥ�
#	�����ȡ�Ctrl-D �򲡤��Ƥ⽪λ���ʤ��ʤ�ޤ���
#	( IRIX/AIX �ʳ��Ǥϡ�ɬ�������ȥ����Ȥ��Ƥ����Ƥ���������)
#

# USE_MONITOR		= 1

# MONITOR_READLINE	= 1
# MONITOR_IGNORE_C_D	= 1
# MONITOR_USE_LOCALE	= 1



# PC-8801�Υ����ܡ��ɥХ��򥨥ߥ�졼�Ȥ��������ϡ�
# �ʲ��Υ����ȥ����Ȥ򳰤��Ʋ�������

# USE_KEYBOARD_BUG	= 1



# (X11)
# XFree86-DGA ������Ǥ�����̣�Τ������Ϥɤ���������
#	XFree86-DGA��ͭ���ˤ���ˤϡ�root���¤�ɬ�פʤΤǡ������ղ�������

# X11_DGA		= 1



# (X11)
# XVideo ������Ǥ�����̣�Τ������Ϥɤ���������
#	�ޤ��¸���Ǥ��� ���ޤ�ư���ʤ����⤷��ޤ���

# X11_XV		= 1



#######################################################################
# ������ɴ�Ϣ������
#######################################################################

# MAME/XMAME �١����Υ�����ɽ��Ϥ��Ȥ߹��ޤʤ���硢�ʲ��ιԤ�
# �����ȥ����Ȥ��Ʋ�������

USE_SOUND		= 1



# (X11)
# OS �λ���
#	�ɤ줫��Ĥ���ꤷ�Ƥ���������
#	generic �����֤ȡ�������ɤʤ��ˤʤ�ޤ���
#	�� �� ¾�����֤ȡ�������ɤ���ˤʤ���⤢��ޤ���
#	ư���ǧ�����Ƥ���Τϡ�FreeBSD �� Linux �ΤߤǤ�

#---------------------- FreeBSD
# ARCH = freebsd
#---------------------- Linux
# ARCH = linux
#---------------------- NetBSD
# ARCH = netbsd
#---------------------- OpenBSD
# ARCH = openbsd
#---------------------- Solaris / SunOS
# ARCH = solaris
#---------------------- QNX Neutrino (QNX4/QNX6)
# ARCH = nto
#---------------------- OpenStep on NeXT systems
# ARCH = next
#---------------------- OpenStep on Apple systems (Cocoa)
ARCH = macosx
#---------------------- IRIX ( with sound using the old AL (version 1) package)
# ARCH = irix
#---------------------- IRIX ( with sound using the al (IRIX 6.x) package)
# ARCH = irix_al
#---------------------- AIX ( with sound, you'll need the UMS and SOM lpp's installed ( under AIX4 ))
# ARCH = aix
#---------------------- BeOS on Intel
# ARCH = beos
#---------------------- generic UNIX, no sound
# ARCH = generic



# (X11)
# ������ɥǥХ����λ���
#	�ɲä������ǥХ���������С������ȥ����Ȥ򳰤��ޤ���
#	�������ư���ǧ����Ƥ��ޤ���

# SOUND_ESOUND		= 1
# SOUND_ALSA		= 1
# SOUND_ARTS_TEIRA	= 1
# SOUND_ARTS_SMOTEK	= 1
# SOUND_SDL		= 1
# SOUND_WAVEOUT		= 1



# QUASI88 ver 0.6.3 �����ˤƻ��Ѥ��Ƥ������Ť��С������� MAME/XMAME ��
# ������ɽ��Ϥ���Ѥ��������ϡ��ʲ��Υ����ȥ����Ȥ򳰤��Ʋ�������
#	ư���ɬ�פʥ꥽���������ʤ�Ȥʤ�ޤ���

# USE_OLD_MAME_SOUND	= 1



#######################################################################
# fmgen (FM Sound Generator) ������
#######################################################################

# cisc���Ρ�fmgen (FM Sound Generator) ���Ȥ߹��ޤʤ���硢�ʲ��ιԤ�
# �����ȥ����Ȥ��Ʋ�������

USE_FMGEN	= 1


# ���ա�
#	FM Sound Generator �� C++ �ˤ���������Ƥ��ޤ���
#	C++ �Υ���ѥ���������ʲ��ǹԤʤäƲ�������
# 
# 	���ꤹ�٤����ܤϡ�CXX��CXXFLAGS��CXXLIBS ����� LD ������Ǥ���
# 



#######################################################################
# SDL�饤�֥�������
#######################################################################

# (X11/SDL/GTK)
# �ʲ��ξ�硢SDL�饤�֥�꤬���Ѥ���ޤ���
#	��SDL_VERSION �����򤷤����
#	��GTK_VERSION �����򤷡���USE_SOUND = 1�פ���ꤷ�����
#	�����祤���ƥ��å�������� ��X11_JOYSTICK = joy_sdl�פ���ꤷ�����
#	��������ɤ�����ǡ���SOUND_SDL = 1�פ���ꤷ�����
# �����Ǥϡ�sdl-config ��¹Ԥ��륳�ޥ�ɤ���ꤷ�Ƥ���������
#	�̾��OS �ξ�硢sdl-config   �Τޤޤ�����פʤϤ��Ǥ���
#	FreeBSD  �ξ�硢sdl12-config �ʤɤ˥�͡��व��Ƥ��뤳�Ȥ�����ޤ�

SDL_CONFIG	= sdl-config



#######################################################################
# GTK�饤�֥�������
#######################################################################

# (GTK)
# GTK_VERSION �����򤷤����Τߡ��ʲ������꤬ɬ�פǤ���

GTK_CONFIG	= gtk-config



#######################################################################
# ����ѥ����Ϣ������
#######################################################################

# ����ѥ���λ���

CC	= gcc


# ɬ�פ˱����ơ�����ѥ��륪�ץ���� (��Ŭ���ʤ�) ����ꤷ�Ƥ�������
#	gcc �ʤ顢 -fomit-frame-pointer �� -fstrength-reduce �� -ffast-math ��
#	-funroll-loops �� -fstrict-aliasing �������֤κ�Ŭ�����ץ����Ǥ���
#
#	����ѥ���ˤ�äƤϡ�char �� signed char �Ȥߤʤ����꤬ɬ�פʾ�礬
#	����ޤ���PowerPC �Ϥ� gcc �ʤɤ������Ǥ��������ξ�硢-fsigned-char 
#	����ꤷ�ޤ���

CFLAGS = -O2

# �㤨�� gcc & PowerPC �ξ�硢�ʲ��Υ����ȥ����Ȥ򳰤��ޤ���
# CFLAGS += -fsigned-char

# �㤨�� gcc �Ǻ�Ŭ���򤷤�����硢�ʲ��Υ����ȥ����Ȥ򳰤��ޤ���
# CFLAGS += -fomit-frame-pointer -fstrength-reduce -funroll-loops -ffast-math



# ����ѥ���ˤ�äƤϡ�����饤��ؿ���Ȥ����Ȥ�����ޤ���
#	�ʲ����顢Ŭ�ڤʤ�Τ��Ĥ������ꤷ�Ƥ���������
#-------------------------------------------------- �ɤ�ʥ���ѥ���Ǥ�OK
# USEINLINE	= '-DINLINE=static'
#-------------------------------------------------- GCC �ξ��
USEINLINE	= '-DINLINE=static __inline__'
#-------------------------------------------------- Intel C++ ����ѥ���ξ��
# USEINLINE	= '-DINLINE=static inline'
#--------------------------------------------------


# X11 ��Ϣ�Υǥ��쥯�ȥ�ȥ饤�֥������

# �����Υ����ƥ� (?)
# X11INC  	= -I/usr/include/X11
# X11LIB  	= -L/usr/lib/X11

# XFree86 �ξ�� (?)
# X11INC  	= -I/usr/X11R6/include
# X11LIB  	= -L/usr/X11R6/lib

# X.Org �ξ��
X11INC  	= -I/usr/local/include
X11LIB  	= -L/usr/local/lib





# C++ ����ѥ��������
#
#	�������꤬ɬ�פʤΤϡ� fmgen ���Ȥ߹�����ΤߤǤ���
#	gcc �Ϥ���Τ� g++ ��̵����硢��CXX = gcc�פȤ��ƤߤƤ���������

CXX	 = g++
CXXFLAGS = $(CFLAGS)
CXXLIBS	 = -lstdc++


# ��󥫤�����
#	C++ ����ѥ����Ȥ���硢�Ķ��ˤ�äƤ� $(CXX) �Ȥ���ɬ�פ�
#	���뤫�⤷��ޤ���

LD	= $(CC) -Wl
# LD	= $(CXX) -Wl,-s


#######################################################################
# ���󥹥ȡ��������
#######################################################################

# ���󥹥ȡ�����ǥ��쥯�ȥ������
#

BINDIR = /usr/local/bin



###############################################################################
#
# �Խ������Ĥ��줵�ޤǤ�����
# ����ʹߤϡ��ѹ����פΤϤ��Ǥ���¿ʬ������
#
###############################################################################

######## �¸����줳��

# �����ȥ����Ȥ���ȡ����� bpp �� X�Ķ��ˤ�����ư����ǽ�ˤʤ�¸�

X11_SUPPORT_8BPP	= 1
X11_SUPPORT_16BPP	= 1
X11_SUPPORT_32BPP	= 1

# �����ȥ����Ȥ���ȡ��ܥ������Ǥ�ɽ�����Ǥ��ʤ��ʤ�¸�

SUPPORT_DOUBLE		= 1

# �����ȥ����Ȥ���ȡ�utf-8 �Υ��ݡ��Ȥ��ʤ��ʤ�¸�

SUPPORT_UTF8		= 1

# ���ߡ�����ѥ���μ¸�
#	X11_VERSION, SDL_VERSION, GTK_VERSION �Τ������������ʤ���硢
#	src/MINI �ʲ��Υ�������Ȥäơ����ߡ��Υ���ѥ��뤬�¹Ԥ���롣
#	�������̵���ˤ��뤫�� 'ARCH = generic' ����ꤷ�Ƥ������ȡ�



#######################################################################
#
#######################################################################

# ���󥯥롼�ɥǥ��쥯�ȥ�

CFLAGS += -Isrc


#
# �С�������������
#

ifdef	X11_VERSION

# X11 �С������Ǥ�����

CFLAGS += -Isrc/FUNIX -Isrc/X11 $(X11INC) 
LIBS   += $(X11LIB) -lX11 -lXext

# X11�С�������ɽ���ޤ��

ifdef	X11_MITSHM
CFLAGS += -DMITSHM 
endif

ifdef	X11_DGA
CFLAGS += -DUSE_DGA
LIBS   += -lXxf86dga -lXxf86vm
endif

ifdef	X11_XV
CFLAGS += -DUSE_XV
LIBS   += -lXv
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

# X11�С������ǤΥ��祤���ƥ��å�����

ifeq ($(X11_JOYSTICK),joy_sdl)

CFLAGS += -DJOY_SDL -I/Library/Frameworks/SDL.framework/Headers
LIBS   +=           -F/Library/Frameworks -framework SDL

else

ifeq ($(X11_JOYSTICK),joy_linux_usb)
CFLAGS += -DJOY_LINUX_USB
else

ifeq ($(X11_JOYSTICK),joy_bsd_usb)

CFLAGS += -DJOY_BSD_USB

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

else
CFLAGS += -DJOY_NOTHING
endif

endif
endif

# X11�С������Ǥλ�¿������

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

# SDL�С������Ǥ�����

CFLAGS += -Isrc/FUNIX -Isrc/SDL -I/Library/Frameworks/SDL.framework/Headers
LIBS   +=                       -F/Library/Frameworks -framework SDL

CFLAGS += -DQUASI88_SDL

else
ifdef	GTK_VERSION

# GTK�С������Ǥ�����

CFLAGS += -Isrc/FUNIX -Isrc/GTK `$(GTK_CONFIG) --cflags`
LIBS   +=                       `$(GTK_CONFIG) --libs`

CFLAGS += -DQUASI88_GTK

else

# MINI�С������Ǥ�����

CFLAGS +=  -Isrc/FDUMMY -Isrc/MINI

CFLAGS += -DQUASI88_MINI

endif
endif
endif



# ��˥����⡼��ͭ����������


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


# ����¾

ifdef	SUPPORT_DOUBLE
CFLAGS += -DSUPPORT_DOUBLE
endif

ifdef	SUPPORT_UTF8
CFLAGS += -DSUPPORT_UTF8
endif

ifdef	USE_SSS_CMD
CFLAGS += -DUSE_SSS_CMD
endif

ifdef	USE_KEYBOARD_BUG
CFLAGS += -DUSE_KEYBOARD_BUG
endif





#######################################################################
# ������ɤ�ͭ���ˤʤäƤ�����γƼ����
#	�����Ǥϡ�
#		SOUND_OBJS
#		SOUND_LIBS
#		SOUND_CFLAGS
#	���������롣
#######################################################################
ifdef	USE_SOUND

#
# �������ͭ�����Ρ��ɲå��֥������� ( OS��¸�� + ������ )
#

#### �ǥ��쥯�ȥ�

ifdef	USE_OLD_MAME_SOUND
SNDDRV_DIR	= snddrv-old
else
SNDDRV_DIR	= snddrv
endif

SD_Q88_DIR	= $(SNDDRV_DIR)/quasi88
SD_X11_DIR	= $(SNDDRV_DIR)/quasi88/X11
SD_SDL_DIR	= $(SNDDRV_DIR)/quasi88/SDL

SRC_DIR		= $(SNDDRV_DIR)/src
SOUND_DIR	= $(SNDDRV_DIR)/src/sound
UNIX_DIR	= $(SNDDRV_DIR)/src/unix
SYSDEP_DIR	= $(SNDDRV_DIR)/src/unix/sysdep
DSP_DIR		= $(SNDDRV_DIR)/src/unix/sysdep/dsp-drivers
MIXER_DIR	= $(SNDDRV_DIR)/src/unix/sysdep/mixer-drivers


#### ���֥�������

SOUND_OBJS_BASE	= $(SD_Q88_DIR)/mame-quasi88.o	\
		  $(SD_Q88_DIR)/beepintf.o	\
		  $(SD_Q88_DIR)/beep.o		\
		  $(SRC_DIR)/driver.o		\
		  $(SRC_DIR)/restrack.o		\
		  $(SRC_DIR)/sound.o		\
		  $(SRC_DIR)/sndintrf.o		\
		  $(SRC_DIR)/streams.o		\
		  $(SOUND_DIR)/flt_vol.o	\
		  $(SOUND_DIR)/flt_rc.o		\
		  $(SOUND_DIR)/wavwrite.o	\
		  $(SOUND_DIR)/2203intf.o	\
		  $(SOUND_DIR)/2608intf.o	\
		  $(SOUND_DIR)/ay8910.o		\
		  $(SOUND_DIR)/fm.o		\
		  $(SOUND_DIR)/ymdeltat.o	\
		  $(SOUND_DIR)/samples.o

SOUND_OBJS_UNIX	= $(UNIX_DIR)/sound.o			\
		  $(SYSDEP_DIR)/rc.o			\
		  $(SYSDEP_DIR)/misc.o			\
		  $(SYSDEP_DIR)/plugin_manager.o	\
		  $(SYSDEP_DIR)/sysdep_dsp.o		\
		  $(SYSDEP_DIR)/sysdep_mixer.o		\
		  $(SYSDEP_DIR)/sysdep_sound_stream.o

SOUND_OBJS.linux   = $(DSP_DIR)/oss.o $(MIXER_DIR)/oss.o
SOUND_OBJS.freebsd = $(DSP_DIR)/oss.o $(MIXER_DIR)/oss.o
SOUND_OBJS.netbsd  = $(DSP_DIR)/netbsd.o
#SOUND_OBJS.openbsd = $(DSP_DIR)/oss.o $(MIXER_DIR)/oss.o
SOUND_OBJS.openbsd = $(DSP_DIR)/netbsd.o 
SOUND_OBJS.solaris = $(DSP_DIR)/solaris.o $(MIXER_DIR)/solaris.o
SOUND_OBJS.next    = $(DSP_DIR)/soundkit.o
SOUND_OBJS.macosx  = $(DSP_DIR)/coreaudio.o
SOUND_OBJS.nto     = $(DSP_DIR)/io-audio.o
SOUND_OBJS.irix    = $(DSP_DIR)/irix.o
SOUND_OBJS.irix_al = $(DSP_DIR)/irix_al.o
SOUND_OBJS.beos    =
SOUND_OBJS.generic =
#these need to be converted to plugins first
#SOUND_OBJS.aix     = $(DSP_DIR)/aix.o


#### C�ե饰

CFLAGS           += -DUSE_SOUND

SOUND_CFLAGS      = -DPI=M_PI -I$(SRCDIR)/$(SNDDRV_DIR) -I$(SRCDIR)/$(SD_Q88_DIR) -I$(SRCDIR)/$(SRC_DIR) -I$(SRCDIR)/$(SOUND_DIR) -Wno-missing-declarations -Wno-unused

SOUND_CFLAGS_UNIX = -I$(SRCDIR)/$(SD_X11_DIR) -I$(SRCDIR)/$(UNIX_DIR) -I$(SRCDIR)/$(SYSDEP_DIR) -I$(SRCDIR)/$(DSP_DIR) -I$(SRCDIR)/$(MIXER_DIR)


#### �С�������������

ifdef	X11_VERSION

#
# X11 �С������ǤΥ����������
#

SOUND_OBJS	= $(SOUND_OBJS_BASE)		\
		  $(SD_X11_DIR)/audio.o		\
		  $(SOUND_OBJS_UNIX)		\
		  $(SOUND_OBJS.$(ARCH))


#
# �������ͭ�����Υ���ѥ��륪�ץ����
#	-DHAVE_SNPRINTF, -DHAVE_VSNPRINTF �����פΤϤ���

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
# �������ͭ�����Υ饤�֥�����
#	�ط�̵���Τ�ޤޤ�Ƥ������ġġ�

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
# �ɲå�����ɥǥХ���������Ρ��ɲ�����
#

ifdef SOUND_ESOUND
SOUND_CFLAGS += -DSYSDEP_DSP_ESOUND `esd-config --cflags`
SOUND_LIBS   += `esd-config --libs`
SOUND_OBJS   += $(DSP_DIR)/esound.o
endif

ifdef SOUND_ALSA
SOUND_CFLAGS += -DSYSDEP_DSP_ALSA -DSYSDEP_MIXER_ALSA
SOUND_LIBS   += -lasound
SOUND_OBJS   += $(DSP_DIR)/alsa.o $(MIXER_DIR)/alsa.o
endif

ifdef SOUND_ARTS_TEIRA
SOUND_CFLAGS += -DSYSDEP_DSP_ARTS_TEIRA `artsc-config --cflags`
SOUND_LIBS   += `artsc-config --libs`
SOUND_OBJS   += $(DSP_DIR)/artssound.o
endif

ifdef SOUND_ARTS_SMOTEK
SOUND_CFLAGS += -DSYSDEP_DSP_ARTS_SMOTEK `artsc-config --cflags`
SOUND_LIBS   += `artsc-config --libs`
SOUND_OBJS   += $(DSP_DIR)/arts.o
endif

ifdef SOUND_SDL
SOUND_CFLAGS += -DSYSDEP_DSP_SDL `$(SDL_CONFIG) --cflags`
SOUND_LIBS   += `$(SDL_CONFIG) --libs`
SOUND_OBJS   += $(DSP_DIR)/sdl.o
endif

ifdef SOUND_WAVEOUT
SOUND_CFLAGS += -DSYSDEP_DSP_WAVEOUT
SOUND_OBJS   += $(DSP_DIR)/waveout.o
endif



else
ifdef	SDL_VERSION

#
# SDL �С������ǤΥ����������
#

SOUND_OBJS	= $(SOUND_OBJS_BASE)		\
		  $(SD_SDL_DIR)/audio.o		\
		  $(SD_SDL_DIR)/sdl.o

SOUND_CFLAGS	+= -I$(SRCDIR)/$(SD_SDL_DIR) -DSYSDEP_DSP_SDL

else
ifdef	GTK_VERSION

#
# GTK �С������ǤΥ����������
#	SDL �ˤ��Ĥ餹���Ȥˤ���

SOUND_OBJS	= $(SOUND_OBJS_BASE)		\
		  $(SD_SDL_DIR)/audio.o		\
		  $(SD_SDL_DIR)/sdl.o
SOUND_CFLAGS	+= -I$(SRCDIR)/$(SD_SDL_DIR) -DSYSDEP_DSP_SDL `$(SDL_CONFIG) --cflags`
SOUND_LIBS	+= `$(SDL_CONFIG) --libs`


#	OSS���Ĥ餽���Ȥ��������Υ������餱�Ǥ��ޤ��Ĥ�ʤ��ġ�

#SOUND_OBJS	= $(SOUND_OBJS_BASE)		\
#		  $(SD_X11_DIR)/audio.o		\
#		  $(SOUND_OBJS_UNIX)		\
#		  $(SOUND_OBJS.$(ARCH))
#SOUND_CFLAGS	+= -D__ARCH_$(ARCH) -DSYSDEP_DSP_OSS -DSYSDEP_MIXER_OSS -DHAVE_SNPRINTF -DHAVE_VSNPRINTF $(SOUND_CFLAGS_UNIX)
#SOUND_LIBS	= -lm

else

#
# MINI �С������ǤΥ����������
#	����ѥ��븡�ڤΤߡ����ϽФʤ�

SOUND_OBJS	= $(SOUND_OBJS_BASE)	\
		  MINI/audio.o
#SOUND_CFLAGS	+=
SOUND_LIBS	= -lm

endif
endif
endif




#### fmgen �����������

ifdef	USE_FMGEN

FMGEN_DIR	= fmgen
FMGEN_OBJ	= $(SD_Q88_DIR)/2203fmgen.o	\
		  $(SD_Q88_DIR)/2608fmgen.o	\
		  $(FMGEN_DIR)/fmgen.o		\
		  $(FMGEN_DIR)/fmtimer.o	\
		  $(FMGEN_DIR)/opna.o		\
		  $(FMGEN_DIR)/psg.o

CFLAGS		+= -DUSE_FMGEN

SOUND_CFLAGS	+= -I$(SRCDIR)/$(FMGEN_DIR)

SOUND_OBJS	+= $(FMGEN_OBJ)

SOUND_LIBS	+= $(CXXLIBS)

endif

endif



#######################################################################
#
#######################################################################


ifdef	X11_VERSION
PROGRAM = quasi88
else
ifdef	SDL_VERSION
PROGRAM = quasi88.sdl
else
ifdef	GTK_VERSION
PROGRAM = quasi88.gtk
else
PROGRAM = quasi88.mini
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
OBJECT = MINI/graph.o MINI/wait.o MINI/event.o MINI/main.o FDUMMY/file-op.o
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

CFLAGS += -DROM_DIR='"$(ROMDIR)"' -DDISK_DIR='"$(DISKDIR)"' \
	  -DTAPE_DIR='"$(TAPEDIR)"' $(USEINLINE) -DCLIB_DECL= 

CXXFLAGS += $(CFLAGS)

LIBS   += $(SOUND_LIBS)

###

SRCDIR		= src

ifdef	X11_VERSION
OBJDIR		= obj
OBJDIRS		+= $(OBJDIR) $(OBJDIR)/X11 $(OBJDIR)/FUNIX
else
ifdef	SDL_VERSION
OBJDIR		= obj.sdl
OBJDIRS		+= $(OBJDIR) $(OBJDIR)/SDL $(OBJDIR)/FUNIX
else
ifdef	GTK_VERSION
OBJDIR		= obj.gtk
OBJDIRS		+= $(OBJDIR) $(OBJDIR)/GTK $(OBJDIR)/FUNIX
else
OBJDIR		= obj.mini
OBJDIRS		+= $(OBJDIR) $(OBJDIR)/MINI $(OBJDIR)/FDUMMY
endif
endif
endif

OBJDIRS		+= $(addprefix $(OBJDIR)/, \
		  	$(SNDDRV_DIR) $(FMGEN_DIR) \
		  	$(SD_Q88_DIR) $(SD_X11_DIR) $(SD_SDL_DIR) \
			$(SRC_DIR) $(SOUND_DIR) $(UNIX_DIR) \
			$(SYSDEP_DIR) $(DSP_DIR) $(MIXER_DIR) )

OBJECTS		= $(addprefix $(OBJDIR)/, $(OBJECT) )



###

all:		$(OBJDIRS) $(PROGRAM)

$(OBJDIRS):
		-mkdir $@

$(PROGRAM):	$(OBJECTS)
		$(LD) $(OBJECTS) $(LIBS) -o $(PROGRAM) 


$(OBJDIR)/$(SNDDRV_DIR)/%.o: $(SRCDIR)/$(SNDDRV_DIR)/%.c
		$(CC) $(CFLAGS) $(SOUND_CFLAGS) -o $@ -c $<

$(OBJDIR)/$(SNDDRV_DIR)/%.o: $(SRCDIR)/$(SNDDRV_DIR)/%.m
		$(CC) $(CFLAGS) $(SOUND_CFLAGS) -o $@ -c $<

$(OBJDIR)/$(SNDDRV_DIR)/%.o: $(SRCDIR)/$(SNDDRV_DIR)/%.cpp
		$(CXX) $(CXXFLAGS) $(SOUND_CFLAGS) -o $@ -c $<

$(OBJDIR)/$(FMGEN_DIR)/%.o: $(SRCDIR)/$(FMGEN_DIR)/%.cpp
		$(CXX) $(CXXFLAGS) $(SOUND_CFLAGS) -o $@ -c $<


$(OBJDIR)/%.o: $(SRCDIR)/%.c
		$(CC) $(CFLAGS) -o $@ -c $<

$(OBJDIR)/%.o: $(SRCDIR)/%.m
		$(CC) $(CFLAGS) -o $@ -c $<

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
		$(CXX) $(CXXFLAGS) -o $@ -c $<


$(OBJDIR)/%.s: $(SRCDIR)/%.c
		$(CC) $(CFLAGS) $(SOUND_CFLAGS) -o $@ -S $<


clean:
		rm -rf $(OBJDIR) $(PROGRAM) $(PROGRAM).core

debug:
		@echo Makefile Debug Target is here.


#
# ���󥹥ȡ���˴ؤ�������
#

INSTALL_TARGET = install-nosuid
ifdef	X11_VERSION
ifdef	X11_DGA
INSTALL_TARGET = install-suid
endif
endif


install:	$(INSTALL_TARGET)

install-nosuid:
		@echo installing binaries under $(BINDIR)...
		@cp $(PROGRAM) $(BINDIR)

install-suid:
		@echo installing binaries under $(BINDIR)...
		@cp $(PROGRAM) $(BINDIR)
		@chmod 4555 $(BINDIR)/$(PROGRAM)


#
#
#


#
# �ե�����ΰ�¸�ط��ι���
#
#	make depend �򤹤�С� Makefile.depend ������(����)����ޤ���
#

SOURCES		= $(subst $(OBJDIR)/, src/, $(OBJECTS) )
SOURCES		:= $(patsubst %.o, %.c, $(SOURCES) )
SOURCES		:= $(patsubst src/fmgen/%.c, src/fmgen/%.cpp, $(SOURCES) )
SOURCES		:= $(subst src/snddrv/quasi88/2203fmgen.c, src/snddrv/quasi88/2203fmgen.cpp, $(SOURCES) )
SOURCES		:= $(subst src/snddrv/quasi88/2608fmgen.c, src/snddrv/quasi88/2608fmgen.cpp, $(SOURCES) )

TMP_FILE = Makefile.tmp
DEP_FILE = Makefile.depend

depend:
		-@gcc -MM $(CFLAGS) $(SOUND_CFLAGS) $(SOURCES) > $(TMP_FILE)
		-@echo '# This file is generated by gcc' >  $(DEP_FILE)
		-@echo '#   Do not edit !'               >> $(DEP_FILE)
		-@echo                                   >> $(DEP_FILE)
		-@perl -ane 'if (/:/) { @L = split(); $$Z = substr( $$L[1], 0, rindex( $$L[1], "/" ) ); $$Z =~ s/^src/$(OBJDIR)/; $$L[0] = $$Z . "/" . $$L[0]; $$_ = join( " ", @L ); print "$$_\n"; } else { print "$$_"; }' $(TMP_FILE) >> $(DEP_FILE)
		-@rm -f $(TMP_FILE)


-include $(DEP_FILE)