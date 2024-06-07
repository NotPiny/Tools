#!/bin/bash

# Config (may be overwritten by arguments)
PLATFORM=canary
VENINSTALLER=v1.4.0 # Must be "vx.x.x"

# Check for arguments
if [ $1 ]; then # Discord version
    PLATFORM=$1
fi

echo Please type your sudo password
sudo echo Activated sudo session

cd ~/tmp
wget -O discord.deb https://discordapp.com/api/download/$PLATFORM?platform=linux

echo Installing discord package...
sudo apt install ./discord.deb -y

if [ $BUILD == "bin" ]; then
    if [ ! -f ~/tmp/vencord-installer ]; then
        echo Vencord installer not found

        echo Downloading vencord installer binary
        wget -O vencord-installer https://github.com/Vencord/Installer/releases/download/$VENINSTALLER/VencordInstallerCli-linux

        chmod a+x ./vencord-installer
    fi

    echo Running vencord installer
    sudo ./vencord-installer -branch auto -install
else 
    echo Using script build
    cd ~/Documents/Code/Remote/Vencord
    echo You are about to be put into a new shell as root
    echo Simply type "./install.sh" to install Vencord
    sudo su
fi

cd ~/tmp
echo Cleaning up..
rm ./discord.deb
