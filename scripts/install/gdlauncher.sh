if [ ! -d ~/PTools/Installers ]; then
    mkdir -p ~/PTools/Installers
fi

cd ~/PTools/Installers
wget -O GDLauncher.AppImage https://gdlauncher.com/download/linux
chmod +x GDLauncher.AppImage
./GDLauncher.AppImage
cd ~