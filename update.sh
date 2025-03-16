#!/usr/bin/env sh

HERE="$PWD"

git submodule init # in case submodules aren't cloned yet (ie: fresh dotfiles)
git submodule update --remote --recursive --merge

cd $HERE