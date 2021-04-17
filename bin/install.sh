#!/bin/sh

# make built scripts executable
chmod 755 "$HERE_PROFILE/open-project"

"$SL" "$HERE_PROFILE/clean-npm" "$OUT/.bin/clean-npm"
"$SL" "$HERE_PROFILE/clean-yarn" "$OUT/.bin/clean-yarn"
"$SL" "$HERE_PROFILE/kill-port" "$OUT/.bin/kill-port"
"$SL" "$HERE_PROFILE/no-mouse-accel" "$OUT/.bin/no-mouse-accel"
