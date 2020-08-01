#!/bin/sh
# symlinks at: .xinitrc

xset r rate 200 30 # match most TTYs to reduce pain of transition
xset -b

# Config the touchpad. Sometimes it has number 13, sometimes 14.
# See (org-id-goto "b6e15fa4-a205-42b5-a925-1bde12640369")
xinput set-prop 13 "Synaptics Tap Action" 0 0 0 0 1 3 0
xinput set-prop 14 "Synaptics Tap Action" 0 0 0 0 1 3 0
xinput set-prop 13 "Synaptics Scrolling Distance" -91 -91
xinput set-prop 14 "Synaptics Scrolling Distance" -91 -91

# Use caps:super to work on a Model M-like keyboard missing Win keys.
# For options reference see ~/.guix-profile/share/X11/xkb/rules/base.lst
setxkbmap -layout 'us,se' -option 'grp:menu_toggle' -option 'caps:super'

picom --daemon
feh --bg-fill /home/kept/Media/Wallpapers/earth_horizon-1920x1080.jpg
# unclutter -idle 1 &

# Here I would exec a premade session.
# exec startlxqt

###############################
#### Try to bake my own session

# Recommended by EXWM
xsetroot -cursor_name left_ptr # Modern cursor (default is shaped like an X)
xhost +SI:localuser:$USER # Disable access control
export _JAVA_AWT_WM_NONREPARENTING=1 # Tell Java apps the WM is non-reparenting

#exec emacs --no-site-lisp --no-site-file --debug-init
#exec emacs --debug-init -Q

# exec emacsclient -c # need emacs-no-x-toolkit-next
#exec "$EXTRA_PROFILES/emacs-w-x11/emacs-w-x11/bin/emacs" --no-site-file --no-site-lisp # For Doom
exec emacs --no-site-file --no-site-lisp # For Doom
# exec tdm --xstart
