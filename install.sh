#!/usr/bin/env bash

set -e -E


install_profile() {
	echo "($profile)"
	HERE_PROFILE="$HERE/$profile"
	install_location="$HERE_PROFILE/install.sh"
	if [ -f "$install_location" ]; then
			. "$install_location"
	else
		echo "WARNING: Install script for ($profile) not found."
	fi
}

if [ "$#" -ne "1" ]; then
	echo "Usage: install.sh \$HOME" >&2
	exit 1
fi

HERE="$(cd "$(dirname "$0")" && pwd)"
OUT="$1"
SL="$HERE/symlink.sh"

cd "$HERE"

profiles=(
	git
	zsh
)


if [ "$2" != "" ]
then
	profile=$2
	echo "Symlinking $profile..."
	install_profile
	echo "Done!"
else
	echo "Symlinking files..."

	for profile in "${profiles[@]}"; do
		install_profile
	done

	echo "Done!"
fi
