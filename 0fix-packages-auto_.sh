#!/bin/bash

clear
echo " "


#inxi -xG


#lsb_release -a

#xdotool getactivewindow set_window --name speedy
#xdotool search --name speedy windowminimize



#xdotool search --name speedy windowactivate
#xdotool key "F11"

#WID=$(xdotool getactivewindow)
#xdotool windowminimize $WID
#xdotool windowactivate $WID
#xdotool key "F11" $WID



# sudo mount -o remount,exec /tmp
#sudo apt-get install libgtk2.0-0:i386 -y

#sudo apt-get install chkrootkit -y
# sudo chkrootkit



#> skanowanie.txt
#gedit skanowanie.txt
#rm skanowanie.txt

#sudo apt-get install rkhunter -y
# sudo rkhunter -c --sk --update --propupd --check --summary 




#--logfile skanowanie_rkh.txt
#gedit skanowanie_rkh.txt
#sudo rm skanowanie_rkh.txt

#sudo rkhunter -c --rwo 
#sudo rkhunter -h
#gksu gedit /var/log/rkhunter.log

#sudo apt-get update


#sudo apt-get install clamav -y
#sudo apt-get install libclamunrar6 -y
#sudo apt-get install clamav-daemon

#sudo freshclam
#updatedb

#locate clamd

#sudo clamscan -r /home


#mkdir virus-vault
#--remove=yes

#sudo clamscan -r --bell / --move=virus-vault --scan-pe=yes --scan-elf=yes --scan-ole2=yes --scan-pdf=yes --scan-swf=yes --scan-html=yes --scan-archive=yes --exclude='(?i)\.(xml|jpg|jpeg|png|gif|avi|mpeg|mpg|mp3|wav|ttf|dic|fon|nls|msi|pak|nw)$' --exclude-dir=/home/$(whoami)/.kodi --exclude-dir=/home/$(whoami)/.cache --exclude-dir=/home/$(whoami)/.firestorm --exclude-dir=/home/$(whoami)/.mozilla --exclude-dir=/home/$(whoami)/.secondlife --exclude-dir=/home/$(whoami)/.PlayOnLinux --exclude-dir=/media/$(whoami)/ --exclude-dir=/opt/metasploit --exclude-dir=/root/.secondlife --exclude-dir=/root/.local/share/Trash

#sudo rm /var/lib/apt/lists/* -vf && sudo apt-get update
#sudo dpkg --configure -a && sudo apt-get update
#sudo sed '$!N; /^\(.*\)\n\1$/!P; D' -i /etc/apt/sources.list

#sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
#sudo rm /etc/apt/sources.list.bak
#sed -n "G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P" -i /etc/apt/sources.list
#sudo awk '!a[$0]++' /etc/apt/sources.list
#sudo sed 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P' -i /etc/apt/sources.list


sudo purge-old-kernels 2> /dev/null

sudo sh -c "curl -# https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -"
#rm -f $HOME/waterfox-classic-latest-x86_64.AppImage

sudo sh -c "echo '10000' > /proc/sys/vm/dirty_writeback_centisecs"
#for i in $(ls -d /etc/apt/sources.list.d/*); do sudo sed '$!N; /^\(.*\)\n\1$/!P; D' -i ${i%%}; done
#cat /etc/apt/sources.list | perl -ne '$H{$_}++ or print' > /tmp/sources.list && sudo mv /tmp/sources.list /etc/apt/sources.list
sudo killall updatedb.mlocate 2>/dev/null
sudo chmod -x /etc/cron.daily/mlocate 2>/dev/null
#sudo chmod +x /etc/cron.daily/mlocate
#sudo cp /etc/cron.daily/mlocate /etc/cron.weekly/mlocate 2>/dev/null
#sudo chmod +x /etc/cron.weekly/mlocate 2>/dev/null


sudo sed -i '/memtest86/,/memtest86/d' /boot/grub/grub.cfg
S="/etc/apt/sources.list" ;
S2="$S ${S}.d/*.list" ;
sudo grep -b "^deb\`cat $S2 |
    grep -i "^deb[[:space:]]http" |
    sort |
    uniq -dc |
    sed -e 's;[[:space:]]\\+[[:digit:]]\\+[[:space:]]\\+deb\\(.\\+$\\);\\1;g'\`$" $S2 >/dev/null 2>/dev/null


#sudo sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P' -i /etc/apt/sources.list
#sudo sed -ni '$!N; /^\(.*\)\n\1$/!P; D' /etc/apt/sources.list.d/additional-repositories.list 2>/dev/null
#sudo sed -ni '$!N; /^\(.*\)\n\1$/!P; D' /etc/apt/sources.list.d/official-package-repositories.list 2>/dev/null


sudo rm -f /etc/apt/sources.list.d/wget-log




#cd "${0%/*}"
sudo cp /etc/apt/sources.list ./sources.list_ >/dev/null 2>/dev/null
cat -n ./sources.list_  >/dev/null 2>/dev/null | sort -k2 -k1n  | uniq -f1 | sort -nk1,1 | cut -f2- > ./sources.list >/dev/null 2>/dev/null
sudo mv ./sources.list_ /etc/apt/sources.list >/dev/null 2>/dev/null
rm ./sources.list >/dev/null 2>/dev/null

katalog=/etc/apt/sources.list.d
katalog2=$(pwd)
#katalog3=$(readlink -f $0)
katalog3="$( cd "$(dirname "$0")" ; pwd -P )"
#katalog3=`dirname $SCRIPT`

#${0%/*}
mkdir listy 2> /dev/null
cd "$katalog"
shopt -s nullglob
for file in *.list
do
echo "Usuwam duplikaty z listy: $file"
#==> 
cat -n "$file" | sort -k2 -k1n  | uniq -f1 | sort -nk1,1 | cut -f2- > "$katalog2/listy/$file"
#cat "$katalog/$file" | perl -ne '$H{$_}++ or print' > "/tmp/$file" && sudo mv "/tmp/$file" "$katalog/$file"

#sudo sed -nr '$!N;/^(.*)\n\1$/!P;D'<"$katalog/$file">"$katalog2/listy2/$file"
#cat $file | sort -u > "$katalog2/listy3/$file"

#==> 
echo qaz123 | sudo -S mv "$katalog2/listy/$file" "$katalog/$file"

done
#==> 
rm -r "$katalog2/listy"

cat /etc/apt/sources.list | perl -ne '$H{$_}++ or print' > /tmp/sources.list && sudo mv /tmp/sources.list /etc/apt/sources.list


#file1=./latest-pepper-flash.sh
#file2=./latest-widevine.sh
#IF test -f "$file1"; then
#  echo ""
#else
#wget https://raw.githubusercontent.com/33Spot/updates/master/latest-pepper-flash.sh
#fi
#IF test -f "$file2"; then
#  echo ""
#else
#wget https://raw.githubusercontent.com/33Spot/updates/master/latest-widevine.sh
#fi
#echo $katalog3
#read rr


sudo snap refresh
flatpak uninstall --unused 2>/dev/null
#pip list --outdated
#pip3 cache purge
#pip3 install --upgrade pip setuptools wheel
#python3 -m pip install --upgrade pip
sudo pip3 list --outdated --format=freeze 2>/dev/null | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U 2>/dev/null







cd $katalog3
[ -f ./latest-pepper-flash.sh ] || wget https://raw.githubusercontent.com/33Spot/updates/master/latest-pepper-flash.sh && chmod +x ./latest-pepper-flash.sh
[ -f ./latest-widevine.sh ] || wget https://raw.githubusercontent.com/33Spot/updates/master/latest-widevine.sh && chmod +x ./latest-widevine.sh
echo 
echo "************************************************************"
./latest-pepper-flash.sh
echo "************************************************************"
./latest-widevine.sh
echo "************************************************************"



sudo rm -f ./wget-log.*
sudo rm -f ./wget-log


#sudo flatpak update 2>/dev/null
sudo apt install -f


sudo dpkg --configure -a
#sudo apt-get update
sudo apt-get check
sudo dpkg --configure -a
#sudo apt-get update -y
sudo apt-get clean -y
sudo apt-get autoclean -y
sudo apt-get clean -y
#sudo apt-get --install -f
sudo apt-get autoremove -y
#sudo dpkg --configure -a
sudo dpkg --configure -a
sudo apt-get -f install
sudo dpkg --configure -a
sudo apt-get clean -y
sudo apt-get --fix-missing install
sudo apt-get --fix-broken install
sudo dpkg --clear-avail
#sudo dpkg --clear-avail
#sudo dpkg --clear-avail
sudo apt-get clean -y
sudo apt-get autoclean -y
sudo apt-get autoremove -y
sudo aptitude dist-upgrade -y
#sudo apt-get update -y
sudo apt-get -f install -y
#&& sudo sudo apt-get upgrade -y
sudo apt-get clean -y
sudo apt-get clean -y
sudo apt-get autoclean -y
sudo apt-get autoremove -y
#sudo apt-get autoremove -y
sudo apt-get install -f -y
#sudo apt-get update && 
sudo dpkg --configure -a
sudo apt-get -u dist-upgrade -y
sudo apt-get -o Debug::pkgProblemResolver=yes dist-upgrade -y
sudo apt-get --fix-missing update -o APT::Cache-Limit=100000000 -y 
sudo apt-get update -y
sudo aptitude dist-upgrade -y
sudo apt-get install -f -y
sudo apt-get autoclean -y
sudo apt-get -f install -y
sudo apt-get autoclean -y
sudo dpkg --configure -a
sudo apt-get -f install -y
sudo apt-get upgrade -y
sudo apt-get --fix-broken install
echo .
echo Refreshing database please wait... \(this might take long time\.\.\.\)
sudo updatedb

#sudo apt-get update
#sudo apt-get install y-ppa-manager -y
#sudo y-ppa-manager

#sudo apt-get install launchpad-getkeys -y

#sudo launchpad-getkeys

#sudo aptitude update && sudo aptitude install gtkorphan
#sudo aptitude update && sudo aptitude upgrade

#sudo aptitude -f

#ctrl+T zaleznosci 
#wyswietl rozwiazanie
#zastosuj rozwiazanie
#U
#Q
#yes


#sudo apt-get remove --purge pepperflashplugin-nonfree
#sudo apt-get clean



#sudo apt-get remove flashplugin* -y
#sudo apt-get install pepperflashplugin-nonfree
#gpg --keyserver pgp.mit.edu --recv-keys 1397BC53640DB551
#gpg --export --armor 1397BC53640DB551 | sudo sh -c 'cat >> /usr/lib/pepperflashplugin-nonfree/pubkey-google.txt'
#sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 1397BC53640DB551
#sudo dpkg-reconfigure pepperflashplugin-nonfree


sudo sh -c "echo '#!/bin/sh' > /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '# Copyright (C) 2006-2013 Bart Martens <bartm@knars.be>' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '#' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '# This program is free software: you can redistribute it and/or modify' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '# it under the terms of the GNU General Public License as published by' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '# the Free Software Foundation, either version 3 of the License, or' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '# (at your option) any later version.' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '#' >> /usr/bin/update-pepperflashplugin-nonfree2" 
sudo sh -c "echo '# This program is distributed in the hope that it will be useful,' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '# but WITHOUT ANY WARRANTY; without even the implied warranty of' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '# GNU General Public License for more details.' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '#' >> /usr/bin/update-pepperflashplugin-nonfree2" 
sudo sh -c "echo '# You should have received a copy of the GNU General Public License' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '# along with this program.  If not, see <http://www.gnu.org/licenses/>.' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'set -e' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'arch=\`dpkg --print-architecture\`' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'deburl=https://dl.google.com/linux/direct/google-chrome-stable_current_"\$arch".deb' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'UNPACKDIR=\`mktemp -d /tmp/pepperflashplugin-nonfree.XXXXXXXXXX\`' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'debfile=google-chrome-stable_current_\"\$arch\".deb' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'wgetoptions=\"\$wgetoptions -O \$UNPACKDIR/\$debfile\" # to change wget message : Saving to ...' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'HOME=/root wget \$wgetoptions \$deburl' >> /usr/bin/update-pepperflashplugin-nonfree2" 
sudo sh -c "echo 'cd \$UNPACKDIR' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'dpkg-deb -x \$debfile unpackchrome' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'sofile=unpackchrome/opt/google/chrome/PepperFlash/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '[ -e \$sofile ] || sofile=unpackchrome/opt/google/chrome-unstable/PepperFlash/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '[ -e \$sofile ] || sofile=unpackchrome/opt/google/chrome-beta/PepperFlash/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '[ -e \$sofile ] || sofile=unpackchrome/opt/google/chrome/PepperFlash/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'mv -f \$sofile /usr/lib/pepperflashplugin-nonfree' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'chown root:root /usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'chmod 644 /usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'jsonfile=unpackchrome/opt/google/chrome/PepperFlash/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '[ -e \$jsonfile ] || jsonfile=unpackchrome/opt/google/chrome-unstable/PepperFlash/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '[ -e \$jsonfile ] || jsonfile=unpackchrome/opt/google/chrome-beta/PepperFlash/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '[ -e \$jsonfile ] || jsonfile=unpackchrome/opt/google/chrome/PepperFlash/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'if [ -e \$jsonfile ]' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'then' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '    mv -f \$jsonfile /usr/lib/pepperflashplugin-nonfree' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '    chown root:root /usr/lib/pepperflashplugin-nonfree/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo '    chmod 644 /usr/lib/pepperflashplugin-nonfree/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'fi' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'cd ..' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo sh -c "echo 'rm -rf \$UNPACKDIR' >> /usr/bin/update-pepperflashplugin-nonfree2"
sudo chmod +x /usr/bin/update-pepperflashplugin-nonfree2
#sudo update-pepperflashplugin-nonfree
#sudo mkdir -p /opt/google/chrome/PepperFlash
#sudo mkdir -p /usr/lib/pepflashplugin-installer
#ln -s /usr/lib/pepflashplugin-installer/libpepflashplayer.so /opt/google/chrome/PepperFlash
#sudo ln -s /opt/google/chrome/PepperFlash/libpepflashplayer.so /usr/lib/pepflashplugin-installer
#sudo dpkg-reconfigure pepperflashplugin-nonfree2
#sudo apt-cache policy browser-plugin-freshplayer-pepperflash
#sudo update-pepperflashplugin-nonfree --status
#sudo update-pepperflashplugin-nonfree --install

#sudo dpkg-reconfigure pepperflashplugin-nonfree2
#sudo update-pepperflashplugin-nonfree --status
#sudo update-pepperflashplugin-nonfree --install

#cat /usr/lib/pepperflashplugin-nonfree/etc-chromium-default.txt | sudo tee -a /etc/chromium-browser/default
#CHROMIUM_FLAGS="$CHROMIUM_FLAGS --ppapi-flash-path=/usr/lib/pepflashplugin-installer/libpepflashplayer.so --ppapi-flash-version=$FLASH_VERSION"

#sudo add-apt-repository ppa:jonathonf/pepperflashplugin-nonfree
#sudo apt update
#sudo apt install pepperflashplugin-nonfree -y
sudo update-pepperflashplugin-nonfree --install
sudo update-pepperflashplugin-nonfree --status
#sudo apt install browser-plugin-freshplayer-pepperflash -y
#read r


