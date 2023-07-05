#wget -nc https://dl.winehq.org/wine-builds/winehq.key
#sudo apt-key add winehq.key
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
#sudo wget -nc -O /usr/share/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt update
#sudo apt install --install-recommends winehq-stable

pkill wine

sudo apt-mark unhold wine-stable wine-stable-amd64 wine-stable-i386 winehq-stable wine-devel-amd64 wine
sudo apt remove winehq-stable wine-stable wine-stable-amd64 wine-stable-i386


version=8.0.0.0~focal-1
version=7.22~focal-1
version=7.0.2~focal-1
sudo apt-get install winehq-stable-amd64=$version wine-stable-amd64=$version wine-stable-amd64=$version wine-stable-i386=$version winetricks
sudo mkdir /opt/wine-stable/share/wine/mono
sudo wget -O - https://dl.winehq.org/wine/wine-mono/7.0.0/wine-mono-7.0.0-x86.tar.xz | sudo tar -xJv -C /opt/wine-stable/share/wine/mono
sudo mkdir /opt/wine-stable/share/wine/gecko
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi
sudo wine /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi
sudo wine /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi
sudo wine /opt/wine-stable/share/wine/mono/wine-mono-7.0.0/support/winemono-support.msi

sudo apt-mark hold wine-stable wine-stable-amd64 wine-stable-i386 winehq-stable wine-devel-amd64 wine

sudo apt install exe-thumbnailer upx-ucl imagemagick icoutils libglib2.0-bin liblnk-utils msitools --reinstall
sudo apt install python3-pip
sudo pip install pefile
sudo pip install pillow==6.2.2
sudo pip install icoextract[thumbnailer]
sudo cp ./exe-dll-msi.thumbnailer /usr/share/thumbnailers
winecfg

