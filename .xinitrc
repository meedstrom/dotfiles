#!/bin/sh
# symlinks at: xinitrc
# shellcheck source=/home/kept/Dotfiles/.profile

[ "$(command -v xrdb)" ] && xrdb -quiet -load ~/.Xresources

if [ "$(command -v xset)" ]; then
    xset r rate 200 30 # match most TTYs to reduce pain of transition
    xset -b
fi

# Config the touchpad. Sometimes it has number 13, sometimes 14, sometimes 12...
# See (org-id-goto "b6e15fa4-a205-42b5-a925-1bde12640369")
if [ "$(command -v xinput)" ]; then
    xinput set-prop 12 "Synaptics Tap Action" 0 0 0 0 1 3 0
    xinput set-prop 13 "Synaptics Tap Action" 0 0 0 0 1 3 0
    xinput set-prop 14 "Synaptics Tap Action" 0 0 0 0 1 3 0
    xinput set-prop 12 "Synaptics Scrolling Distance" -91 -91
    xinput set-prop 13 "Synaptics Scrolling Distance" -91 -91
    xinput set-prop 14 "Synaptics Scrolling Distance" -91 -91
fi

# For options reference see ~/.guix-profile/share/X11/xkb/rules/base.lst
setxkbmap -layout 'us,se' -option 'grp:shifts_toggle' -option 'caps:menu'

# Ensure the existence of keysyms F20-F24.
# These keycodes match kernel KEY_F20, KEY_F21 etc (Xorg adds 8 to the number):
# https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h
# FIXME this doesnt work on xinit
xmodmap -e "keycode 198 = F20" -e "keycode 199 = F21" -e "keycode 200 = F22" -e "keycode 201 = F23" -e "keycode 202 = F24"

"$MY_SCRIPTS/wallpapercycle" &

# Random wallpaper (bright. pre-converted)
# feh --no-fehbg --bg-fill --randomize /home/kept/Media/Wallpapers-brightened/ &

# Random wallpaper (--conversion-timeout enables SVGs)
# feh --no-fehbg --bg-fill --recursive --randomize --conversion-timeout 3 /home/kept/Media/Wallpapers/ &

# picom --daemon
# unclutter -idle 5 &

# Here I would exec a premade session.
# exec startlxqt

###############################
#### Try to bake my own session

# Recommended by EXWM
xsetroot -cursor_name left_ptr # Modern cursor (default is shaped like an X)
xhost +SI:localuser:"$USER" # Disable access control
export _JAVA_AWT_WM_NONREPARENTING=1 # Tell Java apps the WM is non-reparenting

#https://elmord.org/blog/?entry=20200719-switching-to-i3-wm
until emacs --with-profile=doom; do :; done 


# exec emacs --with-profile=doom
# exec emacsclient -c # need emacs-no-x-toolkit so it wont die on X quit
# exec "$EXTRA_PROFILES/emacs-w-x11/emacs-w-x11/bin/emacs" --no-site-file --no-site-lisp # For Doom
# exec emacs --debug-init
# exec dbus-launch --exit-with-session emacs -f exwm-enable
# exec emacs --with-profile=doom --eval="(exwm-enable)"
# exec emacs --eval="(exwm-enable)"
# doom env && exec emacs --no-site-file --no-site-lisp
# doom env && exec emacs --no-site-file --no-site-lisp
# exec tdm --xstart
