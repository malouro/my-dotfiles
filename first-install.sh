# List of stuff to install:
# 1. Git
# 2. Node/NPM
# 3. Yarn
# 4. NVM
# 5. Python 3
# 6. Pyenv
# 7. VS Code
# 8. ???

# Config
# -------------------------------
node_version="14"     # Env var for version of Node
nvm_version="0.38.0"  # Env var for version of nvm
os=$(cat /etc/os-release) # FIGURE THIS OUT?

# INSTALL
# -------------------------------

# Install git & zsh:
apt install git zsh

# Install node/npm:
curl -fsSL "https://deb.nodesource.com/setup_${NODE_VERSION:-node_version}.x" | sudo -E bash -
sudo apt-get install -y nodejs

# Install yarn:
npm install --global yarn # installs via npm lol
# alternatively: https://classic.yarnpkg.com/en/docs/install/#debian-stable

# Install nvm:
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION:-nvm_version}/install.sh" | bash

# Install VS Code:
# TODO!
