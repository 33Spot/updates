sudo dpkg --add-architecture i386 
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources
#sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
#sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources

#sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt-get update

apt-cache madison winehq-stable
version=8.0.0.0~focal-1
version=8.0.1~focal-1
version=7.22~focal-1
version=7.0.2~focal-1
version=7.0.2~focal-1
version=7.0.2~focal-1



#apt policy winehq-stable

pkill wine

sudo apt-mark unhold wine-stable wine-stable-amd64 wine-stable-i386 winehq-stable wine-devel-amd64 wine

sudo apt remove -y winehq-stable wine-stable wine-stable-amd64 wine-stable-i386 -y


#sudo apt remove wine-stable-amd64 wine-stable-i386

#sudo apt install --install-recommends winehq-stable=7.0.2~focal-1
sudo apt-get install wine-stable-amd64=7.0.2~focal-1 -y
sudo apt-get install wine-stable-i386=7.0.2~focal-1 -y
sudo apt-get install wine-stable=7.0.2~focal-1 -y
sudo apt-get install winehq-stable=7.0.2~focal-1 -y

sudo apt-get install libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386

sudo apt-get install winetricks -y









#sudo apt-get install winehq-stable=$version wine-stable=$version wine-stable-amd64=$version wine-stable-i386=$version winetricks
#sudo apt-get install winehq-stable=7.0.2~focal-1 wine-stable=7.0.2~focal-1 wine-stable-amd64=7.0.2~focal-1 wine-stable-i386=7.0.2~focal-1 winetricks
#wine-stable=$version


#sudo apt remove winehq-stable

#sudo apt-get install wine-stable-amd64=7.0.2~focal-1


#sudo apt-get install -y winehq-stable=4.0~xenial wine-stable=4.0~xenial wine-stable-amd64=4.0~xenial wine-stable-i386=4.0~xenial

#wine-stable-i386=$version 
# winehq-stable=$version
#sudo aptitude install winehq-stable=$version


#sudo aptitude install wine-stable=7.0.2~focal-1 wine-stable wine-stable-amd64 wine-stable-i386:i386
#sudo aptitude install winehq-stable=7.0.2~focal-1



#sudo apt-mark hold winehq-staging winehq-devel


#sudo apt remove winehq-staging winehq-devel sudo apt remove wine-staging wine-devel

##sudo apt-get install ttf-mscorefonts-installer

#sudo apt-mark unhold wine-stable wine-stable-amd64 wine-stable-i386:i386 winehq-stable

sudo mkdir -p /opt/wine-stable/share/wine/mono
sudo wget -O - https://dl.winehq.org/wine/wine-mono/7.0.0/wine-mono-7.0.0-x86.tar.xz | sudo tar -xJv -C /opt/wine-stable/share/wine/mono
sudo mkdir -p /opt/wine-stable/share/wine/gecko
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi
sudo wine /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi
sudo wine /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi
sudo wine /opt/wine-stable/share/wine/mono/wine-mono-7.0.0/support/winemono-support.msi

sudo apt-mark hold wine-stable wine-stable-amd64 wine-stable-i386 winehq-stable wine-devel-amd64 wine

winecfg


#sudo apt remove wine wine-development
#sudo apt install wine=7.0.2~focal-1
# wine-development=7.0.2~focal-1

#sudo apt-get install winbind -y
echo latest version of winetricks is:
curl --silent --show-error \
https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks --stderr - \
| grep ^WINETRICKS_VERSION | cut -d '=' -f 2
sudo apt-get remove winetricks -y
wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks 
sudo mv -v winetricks /usr/bin
winetricks --version
#winetricks

sudo apt install exe-thumbnailer upx-ucl imagemagick icoutils libglib2.0-bin liblnk-utils msitools --reinstall
sudo apt install python3-pip
sudo pip install pefile
sudo pip install pillow==6.2.2
sudo pip install icoextract[thumbnailer]
sudo cp ./exe-dll-msi.thumbnailer /usr/share/thumbnailers
winecfg



bash

