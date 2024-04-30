#!/usr/bin/env bash

set -e -E


# Relies on `$profile` var - runs install script from its location
install_profile() {
	echo "($profile)"

	HERE_PROFILE="$HERE/$profile"
	install_location="$HERE_PROFILE/install.sh"

	if [ -f "$install_location" ]; then
		. "$install_location"
	else
		printf "\e[33mWARNING:\e[0m Install script for ($profile) not found; skipping\n"
	fi
}


# Usage prompt:
if [ "$#" -lt "1" ] || [ "$#" -gt "2" ]; then
	echo "Usage: install.sh <directory> (<profile>)" >&2
	printf "\neg:\n\e[1m$\e[0m install.sh \$HOME zsh\n" >&2
	printf "\n> Don't include <profile> to install *all* profiles" >&2
	printf "\n> It's probably best to install in \$HOME," >&2
	printf "but you can install it wherever you want. ;)\n" >&2
	exit 1
fi


HERE="$(cd "$(dirname "$0")" && pwd)"
OUT="$1"
SL="$HERE/symlink.sh"

cd "$HERE"

# Add new profiles/dotfile directorys in here:
profiles=(
	alacritty
	bash
	bin
	git
	node-scripts
	ssh
	tmux
	vim
	vscode
	yarn
	zsh
)


# If a specific profile is sent as a parameter,
# then install just that specified profile:
if [ "$2" != "" ]
then
	profile=$2

	echo "Symlinking $profile..."
	install_profile
	echo "Done!"

# otherwise, install *all* profiles:
else
	echo "Symlinking files..."

	for profile in "${profiles[@]}"; do
		install_profile
	done

	echo "Done!"
fi