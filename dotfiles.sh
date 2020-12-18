#!/bin/sh

link_dotfile() {
	no_link=false

	# Check and prompt to see if dotfile already exists in $HOME
	if [ -f "$location_in_home" ]; then
		while true; do
			read -p "File \"$location_in_home\" already exists. In order to link to this location the file must be removed. Do you wish to remove this file? (y|n) " yn
			case $yn in
					[Yy]* ) rm "$location_in_home"; break;;
					[Nn]* ) echo "Not removing or linking to \"$location_in_home\"."; no_link=true; break;;
					* ) echo "Please answer yes or no. (y|n) ";;
			esac
		done
	fi

	# Symlink dotfile into $HOME
	if [ no_link=false ]
	then
		ln -s "$file_location" "$location_in_home"
	fi
	echo "Linked $file into $HOME ($location_in_home)"
}

if [ "$1" != "" ]
then
	profile=$1
	for file in "$profile"/*
	do
		file_location=$PWD/$file
		location_in_home=$HOME/\."${file##*/}"
		link_dotfile
	done
else
	for dir in ./*/
	do
		dir=${dir%*/}
		echo $dir
		for file in "$dir"/*
		do
			file_location=$PWD/$file
			location_in_home=$HOME/\."${file##*/}"
			link_dotfile
		done
	done
fi
