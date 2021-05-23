export EXTRA_PROFILES="$MY_FILES/guix-profiles"
export ALWAYS_ACTIVE_PROFILES="x11 gtk misc superuser"
#export ALWAYS_ACTIVE_PROFILES="x11 gtk large misc qt rlang superuser"

# Source extra profiles (made by Guix manifests) containing more programs.
for x in $ALWAYS_ACTIVE_PROFILES; do
	if [ -f "$EXTRA_PROFILES/$x/$x/etc/profile" ]; then
		GUIX_PROFILE="$EXTRA_PROFILES/$x/$x" # must be set while sourcing
		. "$EXTRA_PROFILES/$x/$x/etc/profile"
	fi
done

export GUIX_PROFILE="$HOME/.guix-profile" # for some of my scripts
. "$GUIX_PROFILE/etc/profile"
