#!/bin/bash

# Config (may be overwritten by arguments)
PLATFORM=stable
VENINSTALLER=v1.4.0 # Must be "vx.x.x"

# Check for arguments
if [ $1 ]; then # Discord version
    PLATFORM=$1
fi

echo Please type your sudo password
sudo echo Activated sudo session

cd ~/tmp
if [ $0 == "./venupdate.sh" ]; then # Currently developing and i dont need to redownload discord...
    echo Skipping downloading discord because script was ran directly
else
    wget -O discord.deb https://discordapp.com/api/download/$PLATFORM?platform=linux

    echo Installing discord package...
    sudo apt install ./discord.deb -y
fi

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
    echo Running install.sh
    sudo su --command="./install.sh"
fi

cd ~/tmp
echo Cleaning up..
rm ./discord.deb
