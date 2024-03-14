#!/bin/bash

"$SL" "$HERE_PROFILE/alacritty.toml" "$OUT/.alacritty.toml"

if [ -d "$OUT/.config" ]; then
	"$SL" "$HERE_PROFILE/themes/themes" "$OUT/.config/alacritty/themes"
else
	echo '"~/.config" was not found. Not installing Alacritty themes.';
fi
