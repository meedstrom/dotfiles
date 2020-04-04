#!/bin/sh

xinput set-prop 13 "Synaptics Tap Action" 0 0 0 0 1 3 0
xinput set-prop 14 "Synaptics Tap Action" 0 0 0 0 1 3 0
xinput set-prop 13 "Synaptics Scrolling Distance" -91 -91
xinput set-prop 14 "Synaptics Scrolling Distance" -91 -91
setxkbmap -layout 'us,se' -option 'grp:menu_toggle'
xset r rate 200 45
xset -b

picom -b
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

# Start Emacs client or daemon depending
# if [ $(pgrep -x emacs) ]; then
#     echo "Emacs running!"
#     exec emacsclient -c
# else
#     exec emacsclient -a "" -c --eval (load "~/.emacs.d/my-exwm")'
# fi

exec emacs
