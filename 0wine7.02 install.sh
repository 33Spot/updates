#wget -nc https://dl.winehq.org/wine-builds/winehq.key
#sudo apt-key add winehq.key
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
#sudo wget -nc -O /usr/share/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt update
sudo apt install --install-recommends winehq-stable
sudo apt install exe-thumbnailer upx-ucl imagemagick icoutils libglib2.0-bin liblnk-utils msitools --reinstall
sudo apt install python3-pip
sudo pip install pefile
sudo pip install pillow==6.2.2
sudo pip install icoextract[thumbnailer]
sudo cp ./exe-dll-msi.thumbnailer /usr/share/thumbnailers
winecfg
