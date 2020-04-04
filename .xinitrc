#!/bin/sh

# (For Xen DomU) Fix mouse cursor offset over VNC
# if [dmesg | grep -i xen]; then  # borked if
# xinput set-prop "Xen Virtual Pointer" 'Evdev Axis Calibration' 0 1366 0 768


# Sticky keys
# xkbset sticky -twokey -latchlock
# xkbset exp =sticky


# WIP pseudocode to make the desktop the same color as my Emacs theme
#theme=`rg "^\s*(load-theme .*)" | tail -1 | sed 's|^s*(load-theme \(.*\))|\1|'`
#cd `locate -biL "$theme" | xargs dirname`
#bgcolor=`rg "'default.*:background"`
#cd -
#hsetroot $bgcolor

xinput set-prop 13 "Synaptics Tap Action" 0 0 0 0 1 3 0
xinput set-prop 14 "Synaptics Tap Action" 0 0 0 0 1 3 0
xinput set-prop 13 "Synaptics Scrolling Distance" -91 -91
xinput set-prop 14 "Synaptics Scrolling Distance" -91 -91
setxkbmap -layout 'us,se' -option 'grp:menu_toggle'
#setxkbmap -option 'ctrl:swap_lalt_lctl_lwin' -option 'caps:none'
xset r rate 200 45
xset -b

#exec startxfce4

picom -b
#compton --daemon --backend glx --vsync opengl #--invert-color-include 'name *?= "Calibre" || name *?= "Zotero"'
#compton -b
#arbtt-capture &
#cmst --minimized --wait-time 4 &
#dunst -font "Monospace 13" -startup_notification &
#redshift -l 56:13 -t 6500:2700 &
#udiskie --tray &

#exec startlxqt

###############################
#### Try to bake my own session

# Recommended by EXWM
xsetroot -cursor_name left_ptr # Modern cursor (default is shaped like an X)
xhost +SI:localuser:$USER # Disable access control
export _JAVA_AWT_WM_NONREPARENTING=1 # Tell Java apps the WM is non-reparenting

#lxqt-config-input --load-touchpad
#lxqt-powermanagement &
#lxqt-notificationd &
#lxqt-globalkeysd &
#xsettingsd &
#xautolock -locker 'i3lock --image=/home/me/lock.png' &

# TODO: Try linking to a emacs profile's emacs.

# As of commit 0f7269c on 6 Feb 2019, EXWM removed dbus-launch from the example xinitrc.
exec emacs

exec dbus-launch --exit-with-session emacs     -fn "Terminus 9"              
exec dbus-launch --exit-with-session emacs -mm -fn "Terminus 9"              --eval="(require 'exwm)"
exec dbus-launch --exit-with-session emacs -mm -fn "Terminus 9" --debug-init --eval="(require 'exwm)"
exec dbus-launch --exit-with-session emacs -mm -fn "Terminus 9" --debug-init --eval="(progn (require 'exwm) (exwm-enable))"

exec emacs -mm -fn "Terminus 9" --debug-init                --eval="(require 'exwm)"
exec emacs -mm -fn "Terminus 9"                             --eval="(require 'exwm)"
exec emacs -mm -fn "Terminus 9"              --no-site-file --eval="(require 'exwm)"
exec emacs -mm -fn "Terminus 9" --debug-init --no-site-file --eval="(require 'exwm)"

# Start Emacs client or daemon depending
# if [ $(pgrep -x emacs) ]; then
#     echo "Emacs running!"
#     exec emacsclient -c
# else
#     exec emacsclient -a "" -c --eval (load "~/.emacs.d/my-exwm")'
# fi
