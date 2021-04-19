#!/usr/bin/env bash

# -------------------------------
# List of stuff to install:
# 1. Git
# 2. Node/NPM
# 3. Yarn
# 4. NVM
# 5. Python 3 (TODO)
# 6. Pyenv (TODO)
# 7. VS Code (TODO)
# -------------------------------


# Config
# -------------------------------
node_version="14"     # Env var for version of Node
nvm_version="0.38.0"  # Env var for version of nvm
uname_out="$(uname -s)"
case "${uname_out}" in
    Linux*)     os_type=Linux;;
    Darwin*)    os_type=Mac;;
    CYGWIN*)    os_type=Cygwin;;
    MINGW*)     os_type=MinGw;;
    *)          os_type="UNKNOWN:${uname_out}"
esac
echo ${machine}


# INSTALL
# -------------------------------

# Install git & zsh:
apt install git zsh

# Install node/npm:
curl -fsSL "https://deb.nodesource.com/setup_${NODE_VERSION:-node_version}.x" | sudo -E bash -
apt install -y nodejs

# Install yarn:
npm install --global yarn # installs via npm lol
# alternatively: https://classic.yarnpkg.com/en/docs/install/#debian-stable

# Install nvm:
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION:-nvm_version}/install.sh" | bash

# Install Python/pyenv:
# TODO

# Install VS Code:
# TODO
