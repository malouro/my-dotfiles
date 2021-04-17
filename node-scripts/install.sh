#!/usr/bin sh

SHEBANG="#!/usr/bin/env node"

node_scripts=(
	open-project
)

if [ "$RUN_BUILD" == "true" ]; then
	echo 'Running build for node-scripts...'
	echo 'This might take a while. ☕️'

	cd "$HERE_PROFILE" && yarn install && yarn build
else
	echo 'Skipping node-scripts build. 🏃'
fi

# make built scripts executable
for node_script in "${node_scripts[@]}"; do
	file="$HERE_PROFILE/dist/$node_script"
	chmod 755 "$file"

	# check if shebang line exists already
	has_shebang="true?"
	{
		head -n 1 < "$file" | grep -q "^${SHEBANG}"
	} || {
		has_shebang="false"
	}

	if [ "${has_shebang}" != "false" ]; then
		continue
	fi

	add_the_bang=`echo "$SHEBANG"; cat $file`
	echo "$add_the_bang" > "$file"

	"$SL" "$file" "$OUT/.bin/$node_script"
done