#!/bin/sh
# symlinks at: profile
# shellcheck source=/home/kept/Dotfiles/.profile

#################################################################################
# Profile for Bourne-compatible shells (bash(1), zsh(1), dash(1), ...). For
# fish(1), it is probably least effort to start in Bourne and exec fish, which
# will inherit the environment. This makes a single file for all variables.

# EXPLANATION: This is a so-called profile for login shells, which means it is
# only executed when logging in at a TTY and, for some display managers(?), at the
# display manager's startup. Observe that if you first log in to a TTY and start X 
# from there, you have already executed this and X inherits what you've set, and
# so will any programs then started by X. Sub-shells, such as the shell in your
# gnome-terminal, will NOT run this file again. The rationale for its existence
# is to only need executing once, setting variables you expect to be
# constant. Any dynamic configuration should go in shell startup files like
# .bashrc. Some people invoke 'source "~/.profile"' in ~/.bashrc, but that is
# unnecessary because sub-shells inherit the environment -- the only time it
# must be done is when the display manager has ignored this file. Such display
# managers are generally reading from an ~/.xprofile or ~/.xsessionrc, so
# unless you have reason to separate the logic, they should source this or be
# symlinked. In addition, the existence of .bash_profile or .zprofile pre-empts
# reading this file, so if you want this to be read, they must source this.
# If you still have questions, consult the manpage for your shell, they lay it
# all out.

# TIP: if you need complex logic, consider moving it to .bash_profile or
# .zprofile so you can use more powerful language features. An alternative is
# to evaluate, from here, scripts in Bash, Fish, Python, Scheme or your
# favorite language, if you don't mind a hard requirement on installing those
# languages to use the computer. Finally, if mixing with .bash_profile & co,
# look up the load order so you know where to put the exec invocation.

###############################################################################

umask 0077

# Note: Crackable with `env -uLESSSECURE sudo less'.  Better and way more
# universal approach is setting NOEXEC in sudoers.  I keep this as a reminder.
export LESSSECURE=1
readonly LESSSECURE

export EDITOR=emacsclient
export VISUAL=emacsclient
export GTK_THEME="Adwaita:dark"
# export QT_STYLE_OVERRIDE="Adwaita:dark" # needs adwaita-qt

export MY_FILES="/home/kept"
export MY_SCRIPTS="$MY_FILES/code/scripts"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Set up Doom's shell utilities
export EMACSDIR="$HOME/doom-emacs"
export DOOMDIR="$MY_FILES/emacs/conf-doom"
export PATH="$EMACSDIR/bin:$PATH"

# Guix Home ( not tried yet)
#export HOME_ENVIRONMENT=$MY_FILES/Dotfiles/.guix-home
#. $HOME_ENVIRONMENT/setup-environment
#$HOME_ENVIRONMENT/on-first-login

cd "$MY_FILES" || echo

# WIP: If nss-certs isn't in the system or user profile, $SSL_CERT_FILE won't
# be defined at login time, so we have to defer its expansion. For example, a
# profile built around R could have nss-certs included. It may be better to
# define CURL_CA_BUNDLE there somehow, or in R project folders.
# declare -n CURL_CA_BUNDLE="$SSL_CERT_FILE"  # ?

# Specific to Guix System
[ "$(pgrep shepherd)" ] && . "$HOME/profile-guix.sh"

# Specific to Debian
[ "$(command -v apt-get)" ] && . "$HOME/profile-debian.sh"

# Enable Nix
[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && \
	. "$HOME/.nix-profile/etc/profile.d/nix.sh"
export NIX_SSL_CERT_FILE="$SSL_CERT_FILE"

# Try to disable beep
[ "$(command -v setterm)" ] && setterm --blength 0

###############################################################################

# In a running X, like if the user decided to manually source me, end here.
[ "$DISPLAY" ] && return

# On TTY 1, stay with unconfigured bash so I can still log in during breakage.
[ "$XDG_VTNR" -eq 1 ] && return

# On TTY 2, Start X.
[ "$XDG_VTNR" -eq 2 ] && exec startx
# [ "$XDG_VTNR" -eq 2 ] && exec "$HOME/bin/startx-wrapper"
# [ "$XDG_VTNR" -eq 2 ] && exec dbus-run-session sway
# [ "$XDG_VTNR" -eq 2 ] && exec gnome-shell --wayland

# On other TTYs, start emacs.
[ "$(pgrep -fc ttyemacs)" -eq 0 ] && emacs --bg-daemon="ttyemacs"
exec emacsclient -t -s "ttyemacs" -e "(shell \"*shell vt$XDG_VTNR*\")"

###############################################################################
# Defunct stuff (script will never arrive here)

# On other TTYs, switch to Fish. Setting $SHELL was for emacs -nw, I think.
#X="$(command -v fish)" && [ "$X" ] && SHELL="$(realpath $X)" && export SHELL && exec fish
[ "$(command -v fish)" ] && SHELL="$(realpath "$(command -v fish)" )" && export SHELL && exec fish

# If no Fish, source bashrc. Perhaps this should go in .bash_profile, but w/e.
if [ -n "$BASH_VERSION" ]
then
	[ -f "/etc/bashrc" ] && . "/etc/bashrc"
	[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi
###############################################################################
