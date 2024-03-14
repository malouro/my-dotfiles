#!/bin/sh

"$SL" "$HERE_PROFILE/clean-npm" "$OUT/.bin/clean-npm"
"$SL" "$HERE_PROFILE/clean-yarn" "$OUT/.bin/clean-yarn"
"$SL" "$HERE_PROFILE/kill-port" "$OUT/.bin/kill-port"
"$SL" "$HERE_PROFILE/no-mouse-accel" "$OUT/.bin/no-mouse-accel"

# Separate 'icims' folder for work scripts
if [ -d $HERE_PROFILE/icims ]; then
for file in "$HERE_PROFILE/icims"/*; do
	filename=$(basename ${file})
	"$SL" "$HERE_PROFILE/icims/$filename" "$OUT/.bin/$filename"
done
fi
