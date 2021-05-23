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
#setxkbmap -layout 'us,se' -option 'grp:menu_toggle' -option 'caps:super'
setxkbmap -layout 'us,se' -option 'grp:shifts_toggle' -option 'caps:menu'

# Random wallpaper (bright. pre-converted)
# feh --bg-fill --recursive --randomize /home/kept/Media/Wallpapers-brightened/ &

# Random wallpaper (--conversion-timeout enables SVGs)
feh --bg-fill --recursive --randomize --conversion-timeout 3 /home/kept/Media/Wallpapers/ &

picom --daemon
unclutter -idle 1 &

# Here I would exec a premade session.
# exec startlxqt

###############################
#### Try to bake my own session

# Recommended by EXWM
xsetroot -cursor_name left_ptr # Modern cursor (default is shaped like an X)
xhost +SI:localuser:$USER # Disable access control
export _JAVA_AWT_WM_NONREPARENTING=1 # Tell Java apps the WM is non-reparenting

# x doesn't inehrit prfoile anymore so i have to cal lthis again
#. $HOME/profile-guix.sh

#exec emacs --no-site-lisp --no-site-file --debug-init
#exec emacs --debug-init -Q

# exec emacsclient -c # need emacs-no-x-toolkit-next
#exec "$EXTRA_PROFILES/emacs-w-x11/emacs-w-x11/bin/emacs" --no-site-file --no-site-lisp # For Doom
#exec emacs --debug-init
exec dbus-launch --exit-with-session emacs -f exwm-enable
exec emacs -f exwm-enable
exec emacs --eval="(exwm-enable)"
doom env && exec emacs --no-site-file --no-site-lisp
doom env && exec emacs --no-site-file --no-site-lisp
# exec tdm --xstart
