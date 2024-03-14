#!/bin/bash

"$SL" "$HERE_PROFILE/alacritty.toml" "$OUT/.alacritty.toml"

if [ -d "$OUT/.config" ]; then
for file in "$HERE_PROFILE/themes/"*; do
	filename=$(basename ${file});
	"$SL" "$HERE_PROFILE/themes/$filename" "$OUT/.config/alacritty/$filename"
done
fi
