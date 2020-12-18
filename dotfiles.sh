#!/bin/sh

link_dotfile() {
  # Check and prompt to see if dotfile already exists in $HOME
  if [ -f "$location_in_home" ]; then
    while true; do
    read -p "File \"$location_in_home\" already exists. Do you wish to remove this file? (y|n) " yn
    case $yn in
        [Yy]* ) rm "$location_in_home"; break;;
        [Nn]* ) echo "Exiting..."; exit;;
        * ) echo "Please answer yes or no.";;
    esac
    done
  fi

  # Symlink dotfile into $HOME
  ln -s "$file_location" "$location_in_home"
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
