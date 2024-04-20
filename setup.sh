#!/bin/bash

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

# Alright clone the repo (this file is most likely run from "curl -L https://example.com | bash")
git clone https://github.com/NotPiny/Tools ~/PTools

cd ~/PTools/setup
mkdir ~/tmp # Not important for this script though is used a bit in other scripts

npm install
node .