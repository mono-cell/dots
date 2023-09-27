#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xrdb ~/.Xresources
setxkbmap -option 'caps:swapescape'
setxkbmap -option 'altwin:swap_lalt_lwin'
setxkbmap -option 'terminate:ctrl_alt_bksp'
xset r rate 185 65
xset +fp ~/.local/share/fonts
xset fp rehash


dunst &
xcompmgr -n &
(sleep 1s && 1.sh &)
(sleep 3s && nitrogen --restore &)

dbus-run-session /home/jk/.cache/xmonad/xmonad-x86_64-linux
