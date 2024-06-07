if [ ! -f '~/tmp' ]; then
    mkdir ~/tmp
fi

wget -O ~/tmp/code.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
sudo apt install ~/tmp/code.deb -y
rm -f ~/tmp/code.deb