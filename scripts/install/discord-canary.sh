cd ~/tmp
wget -O discord.deb https://discordapp.com/api/download/canary?platform=linux

echo Installing discord package...
sudo apt install ./discord.deb -y

rm -f discord.deb