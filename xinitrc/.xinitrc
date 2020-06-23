#!/bin/sh
setxkbmap -option caps:escape -option compose:ralt

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Fix java windows
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

# Fix font scaling on alacritty
if [ "$(hostname)" = howlback ]; then
    export WINIT_X11_SCALE_FACTOR=1
fi

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# Launch the window manager
exec bspwm 2>&1
