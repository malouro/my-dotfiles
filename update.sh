#!/usr/bin/env sh

HERE="$PWD"

git submodule init # in case submodules aren't cloned yet (ie: fresh dotfiles)
git submodule update --remote --recursive --merge

## This section is not working on Mac?
## probably a skill issue but also the node-scripts aren't *that* important
# cd "$HERE/node-scripts"

# if [which node &> /dev/null] & [which npm &> /dev/null]; then
#   npm install && npm run build
# else
#   echo "Skipping node-scripts update; Node/npm not detected"
# fi

cd $HERE