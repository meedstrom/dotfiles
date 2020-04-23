#!/usr/bin/env bash
source ~/.profile
# source ~/.nix-profile/etc/profile.d/*

# On TTY 1, just start X
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
        exec $HOME/startx.sh
fi

# On other TTYs, switch to the Fish shell
# Small bug: Emacs in a TTY will also try to use Fish in M-x shell
if type -P fish &> /dev/null && test -z $DISPLAY; then exec fish; fi
