echo latest version of winetricks is:
curl --silent --show-error \
https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks --stderr - \
| grep ^WINETRICKS_VERSION | cut -d '=' -f 2
sudo apt-get remove winetricks
wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks 
#sudo mv -v winetricks /usr/local/bin
sudo mv -v winetricks /usr/bin
winetricks --version
winetricks