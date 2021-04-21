#!/usr/bin/env sh

# Script will iterate thru this list
# First matching profile will be used;
# otherwise, defaults to regular profile
npm_profiles=(
	icims
)

profile_match="false"

for profile in "${npm_profiles[@]}"; do
	if [ -f "$HERE_PROFILE/npmrc.$profile" ]; then
		profile_match="true"
		echo "Using $profile npm profile..."
		"$SL" "$HERE_PROFILE/npmrc.$profile" "$OUT/.npmrc"
		break
	fi
done

if [ "$profile_match" == "false" ]; then
	echo "Not using specific npm profile. Installing default:"
	"$SL" "$HERE_PROFILE/npmrc" "$OUT/.npmrc"
fi