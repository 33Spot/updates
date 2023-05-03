#sudo dpkg --add-architecture i386 
#sudo mkdir -pm755 /etc/apt/keyrings
#sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
#sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources

version=8.0.0.0~focal-1
version=7.22~focal-1
version=7.0.2~focal-1

#apt policy winehq-stable

pkill wine
sudo apt-mark unhold wine-stable wine-stable-amd64 wine-stable-i386 winehq-stable

sudo apt remove winehq-stable wine-stable wine-stable-amd64 wine-stable-i386


##sudo apt install --install-recommends winehq-stable


#sudo apt-get install winehq-stable=$version wine-stable=$version wine-stable-amd64=$version wine-stable-i386=$version winetricks
#sudo apt-get install winehq-stable=7.0.2~focal-1 wine-stable=7.0.2~focal-1 wine-stable-amd64=7.0.2~focal-1 wine-stable-i386=7.0.2~focal-1 winetricks
sudo apt-get install winehq-stable=$version wine-stable=$version wine-stable-amd64=$version wine-stable-i386=$version winetricks
#sudo aptitude install winehq-stable=$version


#sudo aptitude install wine-stable=7.0.2~focal-1 wine-stable wine-stable-amd64 wine-stable-i386:i386
#sudo aptitude install winehq-stable=7.0.2~focal-1



#sudo apt-mark hold winehq-staging winehq-devel


#sudo apt remove winehq-staging winehq-devel sudo apt remove wine-staging wine-devel

##sudo apt-get install ttf-mscorefonts-installer

#sudo apt-mark unhold wine-stable wine-stable-amd64 wine-stable-i386:i386 winehq-stable

sudo mkdir /opt/wine-stable/share/wine/mono
sudo wget -O - https://dl.winehq.org/wine/wine-mono/7.0.0/wine-mono-7.0.0-x86.tar.xz | sudo tar -xJv -C /opt/wine-stable/share/wine/mono
sudo mkdir /opt/wine-stable/share/wine/gecko
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi
sudo wine /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi
sudo wine /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86_64.msi
sudo wine /opt/wine-stable/share/wine/mono/wine-mono-7.0.0/support/winemono-support.msi
sudo apt-mark hold wine-stable wine-stable-amd64 wine-stable-i386 winehq-stable

winecfg






bash

