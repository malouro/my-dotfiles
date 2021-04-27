#!/usr/bin/env bash

set -e

NODE_SHEBANG="#!/usr/bin/env node"
NODE_SCRIPTS=$(cat "$HERE_PROFILE/script-list")

echo "List of node-scripts:
------
${NODE_SCRIPTS}
------";

# Check if we need to build the node-scripts again...
if [ "$RUN_BUILD" == "true" ]; then
	echo 'Running build for node-scripts...'
	echo 'This might take a while. ☕️'

	cd "$HERE_PROFILE" && yarn install && yarn build
else
	echo 'Skipping node-scripts build... 🏃'
fi

# Make built scripts executable
# We chmod it and add a shebang to execute via node
for node_script in $NODE_SCRIPTS; do
	file="$HERE_PROFILE/dist/$node_script"
	chmod 755 "$file"

	# Check if shebang line exists already
	needs_shebang="false"
	{
		head -n 1 < "$file" | grep -q "^${NODE_SHEBANG}"
	} || {
		# If previous command fails; that means the shebang line does not exist
		# We'll mark a flag here that says we need to 
		needs_shebang="true"
	}

	if [ "${needs_shebang}" == "true" ]; then
		add_the_bang=`echo "$NODE_SHEBANG"; cat $file`
		echo "$add_the_bang" > "$file"
	fi

	# Link the file in `.bin`
	"$SL" "$file" "$OUT/.bin/$node_script"
done
