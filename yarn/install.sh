#!/usr/bin/env sh

# Script will iterate thru this list
# First matching profile will be used;
# otherwise, defaults to regular profile
yarn_profiles=(
	icims
)

profile_match="false"

for profile in "${npm_profiles[@]}"; do
	if [ -f "$HERE_PROFILE/yarnrc.$profile" ]; then
		profile_match="true"
		echo "Using $profile yarn profile..."
		"$SL" "$HERE_PROFILE/yarnrc.$profile" "$OUT/.yarnrc"
		break
	fi
done

if [ "$profile_match" == "false" ]; then
	echo "Not using specific yarn profile. Installing default:"
	"$SL" "$HERE_PROFILE/yarnrc" "$OUT/.yarnrc"
fi
