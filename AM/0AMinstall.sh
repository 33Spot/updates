sudo apt install coreutils curl grep sed wget sudo
sudo rm -f /usr/local/bin/am
sudo rm -f /opt/am/APP-MANAGER
sudo rm -f /opt/am/APP-MANAGER.*
#wget https://github.com/ivan-hc/AM/raw/refs/heads/main/AM-INSTALLER --output-document=0AMinstall_i.sh
wget https://github.com/ivan-hc/AM/raw/refs/heads/main/INSTALL --output-document=0AMinstall_i.sh
chmod +x ./0AMinstall_i.sh
sudo ./0AMinstall_i.sh
rm -f ./0AMinstall_i.sh
am -c
am -f
am -u
am --disable-notifications
#am nolibfuse freetube
#am -i libreoffice            	freetube onlyoffice             	kdegames               	krita                  	thorium-sse3           	notepad++              	visipics               	celestia-enanched      	ungoogled-chromium     	cloud-browser          	ferdium                	vlc                    	popcorn                	photogimp              	rats-search            	cliniface              	thorium-reader         	yt-dlg                 	librewolf              	opal                   	akuse                  	walc                   	smplayer               	open-video-downloader  	bauh                   	screencloud            	aisleriot              	youtube-download       	rustdesk               	protonup-qt            	stereophotoview        	ff-password-exporter   	celestia               	caesium                	keepassxc              	yt-dlp                 	hugor                  	mpv                    	anydesk                	appimagetool           	btop                   	billard-gl             cpu-x
echo DONE!
read r
bash
