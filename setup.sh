#!/bin/bash

# Activate sudo if not already
echo "Trying to activate sudo..."
if [ "$EUID" -ne 0 ]; then
    sudo echo "Success!"
fi

# Check if node is installed
if ! [ -x "$(command -v node)" ]; then
    # Time to install node (using nvm)
    echo "Node is not installed. Installing node using nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    # I have no clue how this shit works, but it does
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    # No clue if this already done but whats the harm in doing it again
    source ~/.bashrc

    nvm install node
fi

if ! [ -x "$(command -v git)" ]; then
    # Incase they dont have git ig
    sudo apt install git
fi

# Alright clone the repo (this file is most likely run from "curl -L https://tools.piny.dev | bash")
git clone https://github.com/NotPiny/Tools $HOME/PTools

cd $HOME/PTools/setup
mkdir ~/tmp # Not important for this script though is used a bit in other scripts

npm install
echo "Hey the git and node parts of the setup are done however you could run the setup js script by running the following command."
sudo ln -s "$(whereis node)" /usr/bin/node
echo "cd ~/PTools/setup && sudo ./index"