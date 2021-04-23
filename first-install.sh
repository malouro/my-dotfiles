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
	printf "\e[31mERROR:\e[0m System \"${uname_out}\" is not supported or recognized."
	exit 2
elif [[ "$OS" == "Cygwin" || "$OS" == "MinGw" ]]; then
	printf "\e[31mERROR:\e[0m Windows is not supported yet. :("
	exit 1
fi
printf "\e[36mINFO:\e[0m Detected system type: ${OS} (${uname_out})\n\n"
echo "🔎 Checking system for what to install..."


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
# INSTALL SCRIPT DEPS
# -------------------------------
# Utility function
check_installed () {
	if [ -z "$PACKAGE" ]; then
		return 0
	fi

	if [ "$PACKAGE" == "nvm" ]; then
		printf "__________________________________________________________________________________________\n"
		printf "\e[33mWARNING:\e[0m \"nvm\" detection is not working currently.\n"
		printf "If you need to, run this command manually to install \"nvm\" yourself:\n\n"
		printf "  wget -qO- \"https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION:-"$nvm_version"}/install.sh | bash\"\n\n"
		echo "__________________________________________________________________________________________"
		return 0
	fi

	if ! type "$PACKAGE" > /dev/null; then
		echo "📦 \"${PACKAGE}\" not installed; installing..."
		return 1
	fi

	echo "✅ \"${PACKAGE}\" already installed; skipping."
	return 0
}

if [ "$OS" == "Mac" ]; then
	PACKAGE=wget check_installed || brew upgrade wget || brew install wget
	# Just checks for "gls", though coreutils installs more than that
	PACKAGE=gls check_installed || brew upgrade coreutils || brew install coreutils
fi


# -------------------------------
# INSTALL
# -------------------------------

# git & zsh 🐚
if [ "$OS" == "Linux" ]; then
	PACKAGE=git; check_installed || apt install git
	PACKAGE=zsh; check_installed || apt install zsh
elif [ "$OS" == "Mac" ]; then
	PACKAGE=git; check_installed || brew install git
	PACKAGE=zsh; check_installed || brew install zsh
fi

# oh-my-zsh 😱
if [[ "$OS" == "Linux" || "$OS" == "Mac" ]]; then
	if [ -d "$(/bin/zsh -c 'echo $ZSH')" ]; then
		echo "✅ \"oh-my-zsh\" already installed; skipping."
	else
		sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
	fi
fi

# node 📦
PACKAGE=node
if [ "$OS" == "Linux" ]; then
	check_installed || {
		curl -fsSL "https://deb.nodesource.com/setup_${NODE_VERSION:-"$node_version_short"}.x" | sudo -E bash - && apt install -y nodejs;
	}
elif [ "$OS" == "Mac" ]; then
	node_install_url="https://nodejs.org/dist/latest-v${NODE_VERSION:-"$node_version_short"}.x/node-${node_version_long}.pkg"

	check_installed || { curl "${node_install_url}" > "$HOME/Downloads/node-latest.pkg" && installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"; }
fi

# yarn 🧶
PACKAGE=yarn
check_installed || sudo npm install --global yarn
# alternatively: https://classic.yarnpkg.com/en/docs/install/#debian-stable

# nvm 🚛
PACKAGE=nvm
check_installed || {
	echo "\n\nWARNING:\nThe nvm installation should be skipped entirely. (until it's fixed)"
	echo "This is the block of code that should be reached only when attempting to auto-install nvm."
	echo "In other words: this block shouldn't have been reached... looks like you've encountered a bug! 🐛"
	# Command to install nvm
	# TODO: get this working somehow??
	# wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION:-nvm_version}/install.sh" | bash;
}

# python 🐍
# TODO

# vs code 🧑‍💻
# TODO
