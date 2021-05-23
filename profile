# -*- mode: sh -*-
# Profile for Bourne-compatible shells (bash(1), zsh(1), dash(1), ...). For
# fish(1), it is probably least effort to start in Bourne and exec fish, which
# will inherit the environment. This makes a single file for all variables.

# EXPLANATION: This is a so-called profile for login shells, which means it is
# only executed when logging in at a TTY and, for some display managers, at the
# display manager's startup. Observe that if you first log in to a TTY and then
# start X, you have already executed this and X inherits what you've set, and
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
# reading this file, so if you want this to be read, they should source this.
# If you still have questions, consult the manpage for your shell, they lay it
# all out.

# TIP: if you need complex logic, consider moving it to .bash_profile or
# .zprofile so you can use more powerful language features. An alternative is
# to evaluate, from here, scripts in Bash, Fish, Python, Scheme or your
# favorite language, if you don't mind a hard requirement on installing those
# languages to use the computer. Finally, if mixing with .bash_profile & co,
# look up the load order so you know where to put exec.

###############################################################################

export EDITOR=emacsclient
export VISUAL=emacsclient
export GTK_THEME="Adwaita:dark"
# export QT_STYLE_OVERRIDE="Adwaita:dark" # needs adwaita-qt
export MY_FILES="/home/kept"
export MY_SCRIPTS="$MY_FILES/code/shell"
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH"
# export XDG_CONFIG_HOME="$HOME" # .config/
# export XDG_DATA_HOME="$HOME/share" # .local/share/
# export XDG_CACHE_HOME="$HOME/cache" # .cache/
# export CURL_CA_BUNDLE="$SSL_CERT_FILE" # For R install.packages()

umask 0077
cd "$MY_FILES" || echo

# Work around Guix System behavior where /etc/profile loads hardcoded path
# ~/.config/guix instead of respecting XDG_CONFIG_HOME.
#GUIX_PROFILE="$XDG_CONFIG_HOME/guix/current"
#. "$GUIX_PROFILE/etc/profile"

# WIP: If nss-certs isn't in the system or user profile, $SSL_CERT_FILE won't
# be defined at login time, so we have to defer its expansion. For example, a
# profile built around R could have nss-certs included. It may be better to
# define CURL_CA_BUNDLE there somehow, or in R project folders.
# declare -n CURL_CA_BUNDLE="$SSL_CERT_FILE"  # ?

# Guix-specific
[ "$(ps -e | grep shepherd)" ] && . $HOME/profile-guix.sh

# Debian-specific
[ "$(command -v apt-get)" ] && . $HOME/profile-debian.sh

X="$HOME/.nix-profile/etc/profile.d/nix.sh" && [ -e "$X" ] && . "$X"

[ "$(command -v setterm)" ] && setterm --blength 0 # Try to disable bell

###############################################################################

# In a running X, like if the user decided to manually source me, end here.
[ "$DISPLAY" ] && return

# On TTY 1, stay with unconfigured bash so I can still log in during breakage.
[ "$XDG_VTNR" -eq 1 ] && return

# On TTY 2, Start X.
[ "$XDG_VTNR" -eq 2 ] && exec "$HOME/bin/startx-wrapper"

# On other TTYs, switch to Fish. Setting $SHELL was for emacs -nw, I think.
X="$(command -v fish)" && [ $X ] && export SHELL="$(realpath $X)" && exec fish

# If no Fish, source bashrc. This should actually go in .bash_profile but w/e.
if [ -n "$BASH_VERSION" ]
then
	[ -f "/etc/bashrc" ] && . "/etc/bashrc"
	[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi
###############################################################################
