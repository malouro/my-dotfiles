#!/bin/bash

"$SL" "$HERE_PROFILE/gitconfig" "$OUT/.gitconfig"
"$SL" "$HERE_PROFILE/gitconfig.aliases" "$OUT/.gitconfig.aliases"
"$SL" "$HERE_PROFILE/gitconfig.user" "$OUT/.gitconfig.user"

git_profiles=(
	icims
)

# Sync up other git profiles, if they exist
for profile in "${git_profiles[@]}"; do
	if [ -f "$HERE_PROFILE/gitconfig.user.$profile" ]; then
		"$SL" "$HERE_PROFILE/gitconfig.user.$profile" "$OUT/.gitconfig.user.$profile"
	fi
done
