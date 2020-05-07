#!/bin/sh
# Profile for Bourne-compatible shells (bash(1), zsh(1), dash(1), ...). For
# fish(1), it is probably least effort to start in Bourne and exec fish, which
# will inherit the environment. Thus this is a single file for all variables.

# EXPLANATION: This is a so-called profile for login shells, which means it is
# only executed when logging in at a TTY and, for some display managers, at the
# display manager's startup. Observe that if you first log in to a TTY and then
# start X, you have already executed this and X inherits what you've set, and
# so will any programs started by X. Sub-shells, such as the shell in your
# gnome-terminal, will NOT run this file. The rationale for its existence is
# that only needs executing once, setting all the variables you expect to be
# constant. Some people invoke 'source "~/.profile"' in ~/.bashrc, ~/.zshenv,
# and the like, but you do not have to do that because sub-shells inherit the
# environment -- the only time it must be done is when the display manager has
# ignored this file. Such display managers are generally reading from an
# ~/.xprofile or ~/.xsessionrc instead, so symlink them to this one if you
# don't have reason not to. It can(?) also be the case that the existence of
# .bash_profile or .zprofile pre-empts reading this file, so if you have such
# files they should source this one.

# TIP: if you need complex logic, consider moving it to .bash_profile or
# .zprofile so you can use more powerful language features. Keep in mind in
# that case that you must avoid exec invocations here, as I believe login(1)
# sources this file first and would never get to .bash_profile. An alternative
# is to straight-up evaluate scripts in Bash, Fish, Python or your favorite
# language that figure everything out, from here, before getting to the exec
# invocation(s), if you don't mind a hard requirement on those languages being
# installed.

###############################################################################

umask 0077

export EDITOR=emacsclient
export VISUAL=emacsclient
export PATH="$HOME/bin:$PATH"
export EXTRA_PROFILES="/home/kept/Guix profiles"
export SCRIPTS="/home/kept/Code/shell"
export GTK_THEME="Adwaita:dark"
# export QT_STYLE_OVERRIDE="Adwaita:dark" # needs adwaita-qt
export XDG_CONFIG_HOME="$HOME"
export XDG_DATA_HOME="$HOME/share"
export XDG_CACHE_HOME="$HOME/cache"
# export CURL_CA_BUNDLE="$SSL_CERT_FILE" # For R install.packages()

cd /home/kept || echo

# WIP: If nss-certs isn't in the system or user profile, $SSL_CERT_FILE won't
# be defined at login time, so we have to defer its expansion. For example, a
# profile built around R could have nss-certs included. It may be better to
# define CURL_CA_BUNDLE there somehow, or in R project folders.
# declare -n CURL_CA_BUNDLE="$SSL_CERT_FILE"  # ?

# Source extra profiles (made by Guix manifests) containing more programs.
for x in gtk large misc qt rlang superuser; do
	if [ -f "$EXTRA_PROFILES/$x/$x/etc/profile" ]; then
		GUIX_PROFILE="$EXTRA_PROFILES/$x/$x" # must be set when sourcing
		. "$EXTRA_PROFILES/$x/$x/etc/profile"
	fi
done
export GUIX_PROFILE="$HOME/.guix-profile" # for use in some scripts

###############################################################################

# In a running X, like when the user manually re-sources me, end here.
[ "$DISPLAY" ] && exit

# On TTY 1, start X.
[ "$XDG_VTNR" -eq 1 ] && exec "$SCRIPTS/startx-wrapper"

# On other TTYs, switch to the Fish shell.
[ "$(command -v fish)" ] && exec fish

# Guard clause: ignore any appended code.
exit

###############################################################################
