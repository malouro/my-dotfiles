#!/usr/bin sh

if [ "$NO_BUILD" ]; then
	echo 'Skipping node-scripts build. 🏃'
else
	echo 'Running build for node-scripts...'
	echo 'This might take a while. ☕️'

	cd "$HERE_PROFILE" && yarn install && yarn build
fi
