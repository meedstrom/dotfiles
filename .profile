#!/bin/sh
# Profile for Bourne-compatible shells (bash(1), zsh(1), dash(1), ...). For
# fish(1), it is probably least effort to start in Bourne and exec fish, which
# will inherit the environment.

# EXPLANATION: This is a so-called profile for login shells, which means it is
# only executed when logging in at a TTY and, for some display managers, at the
# display manager's startup. Observe that if you first log in to a TTY and then
# start X, you have already executed this. Sub-shells like your gnome-terminal
# will NOT run this file. The rationale for its existence is that it should
# only need executing once, setting all the variables you expect to be
# constant. Now, some people put source("~/.profile") in ~/.bashrc, ~/.zshenv,
# and the like, but you should not have to do that because sub-shells inherit
# the environment -- the only time it must be put in ~/.bashrc is when the
# display manager has ignored this file. But such display managers are
# generally reading from an .xprofile or .xsessionrc instead, so symlink them
# to this one. It can(?) also be the case that the existence of .bash_profile
# or .zprofile pre-empts reading this file, so if you have such files they
# should contain source("~/.profile").

# TIP: if you need complex logic, consider moving it to .bash_profile or
# .zprofile so you can use more powerful language features. But if you do, you
# must avoid exec invocations here, as I believe login(1) sources this first.

# ------------------------------------------------------------------------------

export EDITOR=emacsclient
export VISUAL=emacsclient
export PATH="$HOME/bin:${PATH}"
export GUIX_PROFILE="$HOME/.guix-profile" # i use this in some scripts
export EXTRA_PROFILES="$HOME/profiles"
export CURL_CA_BUNDLE="$SSL_CERT_FILE" # For R install.packages()

# Source extra profiles made by Guix manifests.
for x in gtk large misc qt r superuser; do
	if [ -f "$EXTRA_PROFILES/$x/$x/etc/profile" ]; then
		GUIX_PROFILE="$EXTRA_PROFILES/$x/$x" # must be set when sourcing
		. "$EXTRA_PROFILES/$x/$x/etc/profile"
	fi
done

# On TTY 1, just start X.
if [ ! "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        # exec tdm # start display manager
        exec "$HOME/startx.sh"
fi

# On other TTYs, switch to the Fish shell.
test "$(command -v fish)" && [ -z "$DISPLAY" ] && exec fish
# For reference, the below is more performant as it doesn't spawn a subshell.
# command -v fish >/dev/null 2>&1 && [ -z "$DISPLAY" ] && exec fish
