#!/usr/bin/env bash


# Usage:
# [ENV_FLAGS?] (sudo) ./first-install
#
# [ENV_FLAGS] options:
# -------------------------------
# - NODE_VERSION:     version of `node` to install;
#                     shorthand format (ie: 14.6.0 -> "14")
# - NVM_VERSION:      version of `nvm` to install.
# -------------------------------
# List of stuff to install:
# 1. Git
# 2. zsh
# 3. Node/NPM
# 4. Yarn
# 5. NVM
# 6. Python 3 (TODO)
# 7. Pyenv (TODO)
# 8. VS Code (TODO)


# -------------------------------
# GET SYSTEM INFO
# -------------------------------
uname_out="$(uname -s)"
case "${uname_out}" in
    Linux*)     OS=Linux;;
    Darwin*)    OS=Mac;;
    CYGWIN*)    OS=Cygwin;;
    MINGW*)     OS=MinGw;;
    *)          OS="UNKNOWN"
esac

if [ "$OS" == "UNKNOWN" ]; then
	echo "Error: System \"${uname_out}\" is not supported or recognized."
	exit 2
elif [[ "$OS" == "Cygwin" || "$OS" == "MinGw" ]]; then
	echo "Windows is not supported yet. :("
	exit 1
fi
echo "Detected system type: ${OS} (${uname_out})"



# -------------------------------
# INSTALL SCRIPT DEPS
# -------------------------------
# Utility function
check_installed () {
	if [ -z "$PACKAGE" ]; then
		return 0
	fi
	installed=$(command -v "$PACKAGE")
	echo "$installed"
	if [ -z "${installed}" ]; then
		echo "\"${PACKAGE}\" not installed; installing..."
		return 1
	fi

	echo "\"${PACKAGE}\" already installed; skipping."
	return 0
}

if [ "$OS" == "Mac" ]; then
	PACKAGE=wget check_installed || brew upgrade wget || brew install wget
fi

# -------------------------------
# CONFIG
# -------------------------------
# Version of Node to install (shorthand)
node_version_short=${NODE_VERSION:-"14"}
# Longhand version of Node, given the above value
node_version_long="$(wget -qO- "https://nodejs.org/dist/latest-v${node_version_short}.x/" | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')"
# Version of nvm to install
nvm_version="0.38.0"

# -------------------------------
# INSTALL
# -------------------------------

# git & zsh 🐚
if [ "$OS" == "Linux" ]; then
	PACKAGE=git check_installed || apt install git
	PACKAGE=zsh check_installed || apt install zsh
elif [ "$OS" == "Mac" ]; then
	PACKAGE=git check_installed || brew install git
	PACKAGE=zsh check_installed || brew install zsh
fi

# node 📦
if [ "$OS" == "Linux" ]; then
	if [ PACKAGE=node check_installed -e 1]; then
		echo "Installing NODE???"
		curl -fsSL "https://deb.nodesource.com/setup_${NODE_VERSION:-"$node_version_short"}.x" | sudo -E bash -
		apt install -y nodejs
	fi
elif [ "$OS" == "Mac" ]; then
	node_url="https://nodejs.org/dist/latest-v${NODE_VERSION:-"$node_version_short"}.x/node-${node_version_long}.pkg"

	# Running with "sudo" b/c this whole script _shouldn't_ be ran with "sudo",
	# but this might fail otherwise :(
	if [ PACKAGE=node check_installed -e 1 ]; then
		curl "${node_url}" > "$HOME/Downloads/node-latest.pkg"
		installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"
	fi
fi

# yarn 🧶
if [ PACKAGE=yarn check_installed -e 1 ]; then
	sudo npm install --global yarn # alternatively: https://classic.yarnpkg.com/en/docs/install/#debian-stable
fi

# nvm 🚛
if [ PACKAGE=nvm check_installed -e 1 ]; then
	wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION:-nvm_version}/install.sh" | bash
fi

# python 🐍
# TODO

# vs code 🧑‍💻
# TODO
