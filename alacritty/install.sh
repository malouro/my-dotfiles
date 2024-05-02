#!/bin/bash

# Override with your own var if needed.
USR_APPDATA="${USR_APPDATA:-/mnt/c/Users/micha/AppData/Roaming}"

# Force this with 'OS=Cygwin'
# Potentially, this could come in automatically from <root>/install.sh or somewhere.
if [ $OS = "Cygwin" ]; then
	# We copy because the symlink won't work across our systems the way we want here.
	# So to sync up, run install.sh *again* after updating the alacritty.toml.
	cp "$HERE_PROFILE/alacritty.toml" "$USR_APPDATA/alacritty/alacritty.toml"
else
	"$SL" "$HERE_PROFILE/alacritty.toml" "$OUT/.alacritty.toml"
fi

if [ -d "$OUT/.config" ]; then
	"$SL" "$HERE_PROFILE/themes/themes" "$OUT/.config/alacritty/themes"
else
	echo '"~/.config" was not found. Not installing Alacritty themes.';
fi
