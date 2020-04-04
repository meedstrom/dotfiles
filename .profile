#!/bin/sh
# Profile for Bourne-compatible shells (bash(1), zsh(1), dash(1), ...). For
# fish(1), it's probably least effort to start in bash and then `exec fish`,
# which will inherit these variables.

# Custom prompt
test "${PS1-}" && PS1='\A \w. Sir? '

export EDITOR=emacsclient
export VISUAL=emacsclient
export PATH="$HOME/bin:${PATH}"
export GUIX_EXTRA_PROFILES="$HOME/profiles"

for x in "$GUIX_EXTRA_PROFILES"/*/{misc,r,large,superuser,gtk,qt}; do
	if test -f "$x/etc/profile"; then
		GUIX_PROFILE="$x"
		source "$GUIX_PROFILE"/etc/profile
	fi
done
# for i in "$GUIX_EXTRA_PROFILES"/{misc,r,large,superuser}; do
# 	EXTRA_PROFILE="$i/$(basename $i)"
# 	if [ -f "$EXTRA_PROFILE/etc/profile" ] ; then
# 		GUIX_PROFILE="$EXTRA_PROFILE"
# 		. "$GUIX_PROFILE"/etc/profile
# 	fi
# 	unset EXTRA_PROFILE
# done

export GUIX_PROFILE="$HOME/.guix-profile"
source "$HOME/.guix-profile/etc/profile"
# export GUIX_LOCPATH="$GUIX_PROFILE/lib/locale"
export CURL_CA_BUNDLE="$SSL_CERT_FILE" # for R

# Attempt to fix locale errors
#export PATH="$HOME/.config/guix/current/bin:$HOME/.guix-profile/bin:$PATH"
#export INFOPATH="$HOME/.config/guix/current/share/info:$HOME/.guix-profile/share/info:$INFOPATH"
#export GUILE_LOAD_PATH="${GUIX_PROFILE}/share/guile/site/2.2${GUILE_LOAD_PATH:+:}$GUILE_LOAD_PATH"
#export GUILE_LOAD_COMPILED_PATH="${GUIX_PROFILE}/lib/guile/2.2/site-ccache${GUILE_LOAD_COMPILED_PATH:+:}$GUILE_LOAD_COMPILED_PATH"
#export R_LIBS_SITE="/home/me/.guix-profile/site-library/${R_LIBS_SITE:+:}$R_LIBS_SITE"
#export PATH="/home/me/.config/guix/current/bin${PATH:+:}$PATH"
#export LC_ALL="en_US.UTF-8"

# Unprivileged users can install certificates.
# guix install nss-certs
# export SSL_CERT_DIR="$HOME/.guix-profile/etc/ssl/certs"
# export SSL_CERT_FILE="$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt"
# export GIT_SSL_CAINFO="$SSL_CERT_FILE"
# # As another example, R requires the ‘CURL_CA_BUNDLE’ environment variable to
# # point to a certificate bundle, so you would have to run something like this:
