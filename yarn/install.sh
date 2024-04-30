#!/usr/bin/env sh

# Script will iterate thru this list
# First matching profile will be used;
# otherwise, defaults to regular profile
yarn_profiles=(
	icims
)

profile_match="false"
profile_match_npm="false"

for profile in "${yarn_profiles[@]}"; do
	if [ -f "$HERE_PROFILE/yarnrc.$profile" ]; then
		profile_match="true"
		echo "Using $profile yarn profile..."
		"$SL" "$HERE_PROFILE/yarnrc.$profile" "$OUT/.yarnrc"
		break
	fi
done

for profile in "${yarn_profiles[@]}"; do
	if [ -f "$HERE_PROFILE/npmrc.$profile" ]; then
		profile_match_npm="true"
		echo "Using $profile npm profile..."
		"$SL" "$HERE_PROFILE/npmrc.$profile" "$OUT/.npmrc"
		break
	fi
done

if [ "$profile_match" == "false" ]; then
	echo "Not using specific yarn profile. Installing default:"
	"$SL" "$HERE_PROFILE/yarnrc" "$OUT/.yarnrc"
fi
