#!/bin/sh

MAC_VS_CODE_LOCATION="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
LINUX_VS_CODE_LOCATION="???"

if [ -f "/Applications/Visual Studio Code.app" ]; then
	VS_CODE_LOCATION="${MAC_VS_CODE_LOCATION}"
else
	VS_CODE_LOCATION=${LINUX_VS_CODE_LOCATION}
fi

# Setup VS Code symlink into .bin, dependent on current env
"$SL" "$VS_CODE_LOCATION" "$OUT/.bin/code"

"$SL" "$HERE_PROFILE/clean-npm" "$OUT/.bin/clean-npm"
"$SL" "$HERE_PROFILE/clean-yarn" "$OUT/.bin/clean-yarn"
"$SL" "$HERE_PROFILE/kill-port" "$OUT/.bin/kill-port"
"$SL" "$HERE_PROFILE/no-mouse-accel" "$OUT/.bin/no-mouse-accel"
