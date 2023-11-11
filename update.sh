#!/bin/sh

HERE="$PWD"
git submodule update --remote --merge

cd "$HERE/node-scripts"

if which node &> /dev/null; then
if which npm &> /dev/null; then
  npm install && npm run build
else
  echo "Skipping node-scripts update; Node/npm not detected"
fi
fi

cd $HERE