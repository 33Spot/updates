#sudo apt-get install audacious -y

#sudo apt-get install ppa-purge -y

#sudo ppa-purge ppa:mc3man/mpv-tests -y
#sudo ppa-purge ppa:mc3man/trusty-media -y
#sudo ppa-purge ppa:mc3man/trusty-media -y

#sudo ppa-purge ppa:rvm/testing -y
#sudo apt-get remove mpv smplayer smtube smplayer-themes smplayer-skins youtube-dl -y

#sudo add-apt-repository ppa:mc3man/mpv-tests -y
#sudo apt-get update 
#sudo apt-get install mpv -y

#sudo add-apt-repository ppa:mc3man/xerus-media -y
#sudo apt-get update
#sudo apt-get dist-upgrade -y

#sudo add-apt-repository ppa:mc3man/trusty-media -y
#sudo apt-get update
#sudo apt-get dist-upgrade -y
#sudo apt-get install smplayer smtube smplayer-themes smplayer-skins youtube-dl -y


#wget -nv https://download.opensuse.org/repositories/home:smplayerdev/xUbuntu_14.04/Release.key -O Release.key
#sudo apt-key add - < Release.key
#sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/smplayerdev/xUbuntu_14.04/ /' > /etc/apt/sources.list.d/smplayer.list"
#sudo apt-get update
#sudo apt-get install smplayer
#sudo apt-get install smplayer smtube smplayer-themes smplayer-skins youtube-dl -y

sudo add-apt-repository ppa:rvm/smplayer -y
sudo apt-get update
sudo apt install smplayer smtube smplayer-themes smplayer-skins -y

#(z tego mpv nie instalujemy)


sudo apt-get install oxideqt-codecs-extra
file=all-20110131.tar.bz2
wget http://www1.mplayerhq.hu/MPlayer/releases/codecs/$file
tar -xvjf $file
cd all-20110131
sudo mkdir -p /usr/lib/win32
sudo cp * /usr/lib/win32
cd ..
rm index.html
rm $file
rm -r all-20110131

sudo sed 's/totem/smplayer/g' -i /usr/share/applications/defaults.list
sudo sed 's/xplayer.desktop;//g' -i /usr/share/applications/defaults.list
sudo update-mime-database /usr/share/mime
sudo cp -f ./klawisze_smplayer2.keys /usr/share/smplayer/shortcuts/default.keys
cp -f smplayer.ini ~/.config/smplayer/smplayer.ini
chmod -w ~/.config/smplayer/playlist.ini

sudo add-apt-repository ppa:mc3man/mpv-tests -y
sudo apt-get update
sudo apt install mpv -y