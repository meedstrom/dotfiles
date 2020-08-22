# -*- mode: sh -*-
# Profile for Bourne-compatible shells (bash(1), zsh(1), dash(1), ...). For
# fish(1), it is probably least effort to start in Bourne and exec fish, which
# will inherit the environment. This makes a single file for all variables.

# EXPLANATION: This is a so-called profile for login shells, which means it is
# only executed when logging in at a TTY and, for some display managers, at the
# display manager's startup. Observe that if you first log in to a TTY and then
# start X, you have already executed this and X inherits what you've set, and so
# will any programs started by X. Sub-shells, such as the shell in your
# gnome-terminal, will NOT run this file. The rationale for its existence is to
# only need executing once, setting variables you expect to be constant. Any
# dynamic configuration should go in shell startup files like .bashrc. Some
# people invoke 'source "~/.profile"' in ~/.bashrc, but that is unnecessary
# because sub-shells inherit the environment -- the only time it must be done is
# when the display manager has ignored this file. Such display managers are
# generally reading from an ~/.xprofile or ~/.xsessionrc, so if you don't have
# reason to separate the logic, they should source this or be symlinks. In
# addition, the existence of .bash_profile or .zprofile pre-empts reading this
# file, so if you want this to be read, they must source this or be symlinks.
#  If you
# still have questions, consult the manpage for your shell, they lay it all out.

# TIP: if you need complex logic, consider moving it to .bash_profile or
# .zprofile so you can use more powerful language features. An alternative is to
# straight-up evaluate scripts in Bash, Fish, Python or your favorite language,
# from here, if you don't mind a hard requirement on those languages being
# installed. Put another way, even if you intend to use the Fish shell, you
# could use a script in an even better language (Scheme, Haskell, whatever you
# want) from here, the same for any other "shell scripts" you write. Finally,
# any exec invocation should go here, at least for bash, it reads .bash_profile
# before it does .profile.

###############################################################################

umask 0077

# Start out where I keep my meaningful files
cd /home/kept || echo

[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"

export EDITOR=emacsclient
export VISUAL=emacsclient
# export GTK_THEME="Adwaita:dark"
# export QT_STYLE_OVERRIDE="Adwaita:dark" # needs adwaita-qt
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/emacs-doom/bin:$PATH"
export MY_FILES="/home/kept"
export MY_SCRIPTS="$MY_FILES/Code/shell"
export EXTRA_PROFILES="$MY_FILES/Guix profiles"
export ALWAYS_ACTIVE_PROFILES="x11 gtk large misc qt rlang superuser"
#export XDG_CONFIG_HOME="$HOME" # .config/
#export XDG_DATA_HOME="$HOME/share" # .local/share/
#export XDG_CACHE_HOME="$HOME/cache" # .cache/
# export CURL_CA_BUNDLE="$SSL_CERT_FILE" # For R install.packages()

# Set $SHELL if Fish is available
#[ "$(command -v fish)" ] && SHELL="$(realpath "$(command -v fish)")" && export SHELL

# Work around Guix System behavior where /etc/profile loads hardcoded path
# ~/.config/guix instead of respecting XDG_CONFIG_HOME.
#GUIX_PROFILE="$XDG_CONFIG_HOME/guix/current"
#. "$GUIX_PROFILE/etc/profile"

# WIP: If nss-certs isn't in the system or user profile, $SSL_CERT_FILE won't
# be defined at login time, so we have to defer its expansion. For example, a
# profile built around R could have nss-certs included. It may be better to
# define CURL_CA_BUNDLE there somehow, or in R project folders.
# declare -n CURL_CA_BUNDLE="$SSL_CERT_FILE"  # ?

# Source extra profiles (made by Guix manifests) containing more programs.
#for x in $ALWAYS_ACTIVE_PROFILES; do
#	if [ -f "$EXTRA_PROFILES/$x/$x/etc/profile" ]; then
#		GUIX_PROFILE="$EXTRA_PROFILES/$x/$x" # must be set while sourcing
#		. "$EXTRA_PROFILES/$x/$x/etc/profile"
#	fi
#done
#export GUIX_PROFILE="$HOME/.guix-profile" # for some of my scripts

###############################################################################

# In a running X, like if the user decided for some reason to manually source
# me, end here.
[ "$DISPLAY" ] && return

# Logged in on TTY 1? Start X.
# [ "$XDG_VTNR" -eq 1 ] && exec "$HOME/bin/startx-wrapper"

# On TTY 7, stay with defaults in case the shell startup files are broken. Don't
# want to need system rescue over such a thing.
# [ "$XDG_VTNR" -eq 7 ] && exit

# On other TTYs, switch to Fish.
# [ "$(command -v fish)" ] && SHELL="$(realpath "$(command -v fish)")" && export SHELL && exec fish

# Your TTYs ordinarily appear unconfigured by bashrc, because a login shell,
# i.e. the shells executing me, will not by itself source bashrc (a good
# protection against broken bashrc). Source it anyway.
if [ -n "$BASH_VERSION" ]
then
	[ -f "/etc/bashrc" ] && . "/etc/bashrc"
	[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi
###############################################################################
