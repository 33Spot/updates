#!/bin/bash

clear
script_path=$(readlink -f "$0")
script_dir=$(dirname "$script_path")
cd $script_dir



# Function to check if a package is installed
check_package() {
    dpkg-query -l "$1" &>/dev/null
    return $?
}

# Function to obfuscate the command
obfuscate_command() {
    echo "$1" | base64 -d
}

# Function to obfuscate the passphrase
obfuscate_passphrase() {
    echo "$1" | rev | tr '[:lower:]' '[:upper:]'
}

# Obfuscated stegsnow command
stegsnow_command="c3RlZ3Nub3cgLUMgLXAgMHgzNDB4NTYweDIzMHg3ODB4NzYzMHg0NzB4MjgweDYzMHg2NjB4MzQweDU2MHgyMzB4NzgweDc2MzB4NDcweDI4MHg2MzB4NjYweDM0MHg1NjB4MjMweDc4MHg3NjMweDQ3MHgyODB4NjMweDY2IHBhc3N3b3JkMi5ncGcK"

# Obfuscated passphrase
passphrase="ZnVuY3Rpb24="

# Check if stegsnow package is installed
if ! check_package stegsnow; then
    echo "stegsnow is not installed. It is needed for this script."
    echo "Please install it and try again."
    sleep 15
    exit 1
fi

# Decrypt passphrase
pass=$(obfuscate_passphrase "$passphrase")

# Execute stegsnow command and obtain password
obtained_password=$(obfuscate_command "$stegsnow_command" | bash)

# Check if decryption was successful
if [ -z "$obtained_password" ]; then
    echo "Failed to obtain password from stegsnow command."
    exit 1
fi

# Decrypt password.gpg using obtained password
#echo $stegsnow_command
#echo $passphrase
#echo $pass
#echo $obtained_password

PASSWORD=$(gpg --quiet --decrypt --batch --passphrase "$obtained_password" password.gpg)



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



# echo $PASSWORD | sudo -S mount -o remount,exec /tmp
#echo $PASSWORD | sudo -S apt-get install libgtk2.0-0:i386 -y

#echo $PASSWORD | sudo -S apt-get install chkrootkit -y
# echo $PASSWORD | sudo -S chkrootkit



#> skanowanie.txt
#gedit skanowanie.txt
#rm skanowanie.txt

#echo $PASSWORD | sudo -S apt-get install rkhunter -y
# echo $PASSWORD | sudo -S rkhunter -c --sk --update --propupd --check --summary 




#--logfile skanowanie_rkh.txt
#gedit skanowanie_rkh.txt
#echo $PASSWORD | sudo -S rm skanowanie_rkh.txt

#echo $PASSWORD | sudo -S rkhunter -c --rwo 
#echo $PASSWORD | sudo -S rkhunter -h
#gksu gedit /var/log/rkhunter.log

#echo $PASSWORD | sudo -S apt-get update


#echo $PASSWORD | sudo -S apt-get install clamav -y
#echo $PASSWORD | sudo -S apt-get install libclamunrar6 -y
#echo $PASSWORD | sudo -S apt-get install clamav-daemon

#echo $PASSWORD | sudo -S freshclam
#updatedb

#locate clamd

#echo $PASSWORD | sudo -S clamscan -r /home


#mkdir virus-vault
#--remove=yes

#echo $PASSWORD | sudo -S clamscan -r --bell / --move=virus-vault --scan-pe=yes --scan-elf=yes --scan-ole2=yes --scan-pdf=yes --scan-swf=yes --scan-html=yes --scan-archive=yes --exclude='(?i)\.(xml|jpg|jpeg|png|gif|avi|mpeg|mpg|mp3|wav|ttf|dic|fon|nls|msi|pak|nw)$' --exclude-dir=/home/$(whoami)/.kodi --exclude-dir=/home/$(whoami)/.cache --exclude-dir=/home/$(whoami)/.firestorm --exclude-dir=/home/$(whoami)/.mozilla --exclude-dir=/home/$(whoami)/.secondlife --exclude-dir=/home/$(whoami)/.PlayOnLinux --exclude-dir=/media/$(whoami)/ --exclude-dir=/opt/metasploit --exclude-dir=/root/.secondlife --exclude-dir=/root/.local/share/Trash

#echo $PASSWORD | sudo -S rm /var/lib/apt/lists/* -vf && echo $PASSWORD | sudo -S apt-get update
#echo $PASSWORD | sudo -S dpkg --configure -a && echo $PASSWORD | sudo -S apt-get update
#echo $PASSWORD | sudo -S sed '$!N; /^\(.*\)\n\1$/!P; D' -i /etc/apt/sources.list

#echo $PASSWORD | sudo -S cp /etc/apt/sources.list /etc/apt/sources.list.bak
#echo $PASSWORD | sudo -S rm /etc/apt/sources.list.bak
#sed -n "G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P" -i /etc/apt/sources.list
#echo $PASSWORD | sudo -S awk '!a[$0]++' /etc/apt/sources.list
#echo $PASSWORD | sudo -S sed 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P' -i /etc/apt/sources.list


echo $PASSWORD | sudo -S purge-old-kernels

echo $PASSWORD | sudo -S sh -c "curl -# https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -"
#rm -f $HOME/waterfox-classic-latest-x86_64.AppImage

echo $PASSWORD | sudo -S sh -c "echo '10000' > /proc/sys/vm/dirty_writeback_centisecs"
#for i in $(ls -d /etc/apt/sources.list.d/*); do echo $PASSWORD | sudo -S sed '$!N; /^\(.*\)\n\1$/!P; D' -i ${i%%}; done
#cat /etc/apt/sources.list | perl -ne '$H{$_}++ or print' > /tmp/sources.list && echo $PASSWORD | sudo -S mv /tmp/sources.list /etc/apt/sources.list
echo $PASSWORD | sudo -S killall updatedb.mlocate 2>/dev/null
echo $PASSWORD | sudo -S chmod -x /etc/cron.daily/mlocate 2>/dev/null
#echo $PASSWORD | sudo -S chmod +x /etc/cron.daily/mlocate
#echo $PASSWORD | sudo -S cp /etc/cron.daily/mlocate /etc/cron.weekly/mlocate 2>/dev/null
#echo $PASSWORD | sudo -S chmod +x /etc/cron.weekly/mlocate 2>/dev/null


echo $PASSWORD | sudo -S sed -i '/memtest86/,/memtest86/d' /boot/grub/grub.cfg
S="/etc/apt/sources.list" ;
S2="$S ${S}.d/*.list" ;
echo $PASSWORD | sudo -S grep -b "^deb\`cat $S2 |
    grep -i "^deb[[:space:]]http" |
    sort |
    uniq -dc |
    sed -e 's;[[:space:]]\\+[[:digit:]]\\+[[:space:]]\\+deb\\(.\\+$\\);\\1;g'\`$" $S2 >/dev/null 2>/dev/null


#echo $PASSWORD | sudo -S sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P' -i /etc/apt/sources.list
#echo $PASSWORD | sudo -S sed -ni '$!N; /^\(.*\)\n\1$/!P; D' /etc/apt/sources.list.d/additional-repositories.list 2>/dev/null
#echo $PASSWORD | sudo -S sed -ni '$!N; /^\(.*\)\n\1$/!P; D' /etc/apt/sources.list.d/official-package-repositories.list 2>/dev/null


echo $PASSWORD | sudo -S rm -f /etc/apt/sources.list.d/wget-log




#cd "${0%/*}"
echo $PASSWORD | sudo -S cp /etc/apt/sources.list ./sources.list_ >/dev/null 2>/dev/null
cat -n ./sources.list_  >/dev/null 2>/dev/null | sort -k2 -k1n  | uniq -f1 | sort -nk1,1 | cut -f2- > ./sources.list >/dev/null 2>/dev/null
echo $PASSWORD | sudo -S mv ./sources.list_ /etc/apt/sources.list >/dev/null 2>/dev/null
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


echo $PASSWORD | sudo -S snap refresh







#cd $katalog3
#[ -f ./latest-pepper-flash.sh ] || wget https://raw.githubusercontent.com/33Spot/updates/master/latest-pepper-flash.sh && chmod +x ./latest-pepper-flash.sh
#[ -f ./latest-widevine.sh ] || wget https://raw.githubusercontent.com/33Spot/updates/master/latest-widevine.sh && chmod +x ./latest-widevine.sh
#echo 
#echo "************************************************************"
#./latest-pepper-flash.sh
#echo "************************************************************"
#./latest-widevine.sh
#echo "************************************************************"



echo $PASSWORD | sudo -S rm -f ./wget-log.*
echo $PASSWORD | sudo -S rm -f ./wget-log


#echo $PASSWORD | sudo -S flatpak update 2>/dev/null
echo $PASSWORD | sudo -S apt install -f


echo $PASSWORD | sudo -S dpkg --configure -a
#echo $PASSWORD | sudo -S apt-get update
echo $PASSWORD | sudo -S apt-get check
echo $PASSWORD | sudo -S dpkg --configure -a
#echo $PASSWORD | sudo -S apt-get update -y
echo $PASSWORD | sudo -S apt-get clean -y
echo $PASSWORD | sudo -S apt-get autoclean -y
echo $PASSWORD | sudo -S apt-get clean -y
#echo $PASSWORD | sudo -S apt-get --install -f
echo $PASSWORD | sudo -S apt-get autoremove -y
#echo $PASSWORD | sudo -S dpkg --configure -a
echo $PASSWORD | sudo -S dpkg --configure -a
echo $PASSWORD | sudo -S apt-get -f install
echo $PASSWORD | sudo -S dpkg --configure -a
echo $PASSWORD | sudo -S apt-get clean -y
echo $PASSWORD | sudo -S apt-get --fix-missing install
echo $PASSWORD | sudo -S apt-get --fix-broken install
echo $PASSWORD | sudo -S dpkg --clear-avail
#echo $PASSWORD | sudo -S dpkg --clear-avail
#echo $PASSWORD | sudo -S dpkg --clear-avail
echo $PASSWORD | sudo -S apt-get clean -y
echo $PASSWORD | sudo -S apt-get autoclean -y
echo $PASSWORD | sudo -S apt-get autoremove -y
echo $PASSWORD | sudo -S aptitude dist-upgrade -y
#echo $PASSWORD | sudo -S apt-get update -y
echo $PASSWORD | sudo -S apt-get -f install -y
#&& echo $PASSWORD | sudo -S echo $PASSWORD | sudo -S apt-get upgrade -y
echo $PASSWORD | sudo -S apt-get clean -y
echo $PASSWORD | sudo -S apt-get clean -y
echo $PASSWORD | sudo -S apt-get autoclean -y
echo $PASSWORD | sudo -S apt-get autoremove -y
#echo $PASSWORD | sudo -S apt-get autoremove -y
echo $PASSWORD | sudo -S apt-get install -f -y
#echo $PASSWORD | sudo -S apt-get update && 
echo $PASSWORD | sudo -S dpkg --configure -a
echo $PASSWORD | sudo -S apt-get -u dist-upgrade -y
echo $PASSWORD | sudo -S apt-get -o Debug::pkgProblemResolver=yes dist-upgrade -y
echo $PASSWORD | sudo -S apt-get --fix-missing update -o APT::Cache-Limit=100000000 -y 
echo $PASSWORD | sudo -S apt-get update -y
echo $PASSWORD | sudo -S aptitude dist-upgrade -y
echo $PASSWORD | sudo -S apt-get install -f -y
echo $PASSWORD | sudo -S apt-get autoclean -y
echo $PASSWORD | sudo -S apt-get -f install -y
echo $PASSWORD | sudo -S apt-get autoclean -y
echo $PASSWORD | sudo -S dpkg --configure -a
echo $PASSWORD | sudo -S apt-get -f install -y
echo $PASSWORD | sudo -S apt-get upgrade -y
#echo $PASSWORD | sudo -S apt-get update
#echo $PASSWORD | sudo -S apt-get install y-ppa-manager -y
#echo $PASSWORD | sudo -S y-ppa-manager

#echo $PASSWORD | sudo -S apt-get install launchpad-getkeys -y

#echo $PASSWORD | sudo -S launchpad-getkeys

#echo $PASSWORD | sudo -S aptitude update && echo $PASSWORD | sudo -S aptitude install gtkorphan
#echo $PASSWORD | sudo -S aptitude update && echo $PASSWORD | sudo -S aptitude upgrade

#echo $PASSWORD | sudo -S aptitude -f

#ctrl+T zaleznosci 
#wyswietl rozwiazanie
#zastosuj rozwiazanie
#U
#Q
#yes


#echo $PASSWORD | sudo -S apt-get remove --purge pepperflashplugin-nonfree
#echo $PASSWORD | sudo -S apt-get clean



#echo $PASSWORD | sudo -S apt-get remove flashplugin* -y
#echo $PASSWORD | sudo -S apt-get install pepperflashplugin-nonfree
#gpg --keyserver pgp.mit.edu --recv-keys 1397BC53640DB551
#gpg --export --armor 1397BC53640DB551 | echo $PASSWORD | sudo -S sh -c 'cat >> /usr/lib/pepperflashplugin-nonfree/pubkey-google.txt'
#echo $PASSWORD | sudo -S apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 1397BC53640DB551
#echo $PASSWORD | sudo -S dpkg-reconfigure pepperflashplugin-nonfree


echo $PASSWORD | sudo -S sh -c "echo '#!/bin/sh' > /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '# Copyright (C) 2006-2013 Bart Martens <bartm@knars.be>' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '#' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '# This program is free software: you can redistribute it and/or modify' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '# it under the terms of the GNU General Public License as published by' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '# the Free Software Foundation, either version 3 of the License, or' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '# (at your option) any later version.' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '#' >> /usr/bin/update-pepperflashplugin-nonfree2" 
echo $PASSWORD | sudo -S sh -c "echo '# This program is distributed in the hope that it will be useful,' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '# but WITHOUT ANY WARRANTY; without even the implied warranty of' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '# GNU General Public License for more details.' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '#' >> /usr/bin/update-pepperflashplugin-nonfree2" 
echo $PASSWORD | sudo -S sh -c "echo '# You should have received a copy of the GNU General Public License' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '# along with this program.  If not, see <http://www.gnu.org/licenses/>.' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'set -e' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'arch=\`dpkg --print-architecture\`' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'deburl=https://dl.google.com/linux/direct/google-chrome-stable_current_"\$arch".deb' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'UNPACKDIR=\`mktemp -d /tmp/pepperflashplugin-nonfree.XXXXXXXXXX\`' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'debfile=google-chrome-stable_current_\"\$arch\".deb' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'wgetoptions=\"\$wgetoptions -O \$UNPACKDIR/\$debfile\" # to change wget message : Saving to ...' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'HOME=/root wget \$wgetoptions \$deburl' >> /usr/bin/update-pepperflashplugin-nonfree2" 
echo $PASSWORD | sudo -S sh -c "echo 'cd \$UNPACKDIR' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'dpkg-deb -x \$debfile unpackchrome' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'sofile=unpackchrome/opt/google/chrome/PepperFlash/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '[ -e \$sofile ] || sofile=unpackchrome/opt/google/chrome-unstable/PepperFlash/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '[ -e \$sofile ] || sofile=unpackchrome/opt/google/chrome-beta/PepperFlash/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '[ -e \$sofile ] || sofile=unpackchrome/opt/google/chrome/PepperFlash/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'mv -f \$sofile /usr/lib/pepperflashplugin-nonfree' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'chown root:root /usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'chmod 644 /usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'jsonfile=unpackchrome/opt/google/chrome/PepperFlash/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '[ -e \$jsonfile ] || jsonfile=unpackchrome/opt/google/chrome-unstable/PepperFlash/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '[ -e \$jsonfile ] || jsonfile=unpackchrome/opt/google/chrome-beta/PepperFlash/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '[ -e \$jsonfile ] || jsonfile=unpackchrome/opt/google/chrome/PepperFlash/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'if [ -e \$jsonfile ]' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'then' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '    mv -f \$jsonfile /usr/lib/pepperflashplugin-nonfree' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '    chown root:root /usr/lib/pepperflashplugin-nonfree/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo '    chmod 644 /usr/lib/pepperflashplugin-nonfree/manifest.json' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'fi' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'cd ..' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S sh -c "echo 'rm -rf \$UNPACKDIR' >> /usr/bin/update-pepperflashplugin-nonfree2"
echo $PASSWORD | sudo -S chmod +x /usr/bin/update-pepperflashplugin-nonfree2
#echo $PASSWORD | sudo -S update-pepperflashplugin-nonfree
#echo $PASSWORD | sudo -S mkdir -p /opt/google/chrome/PepperFlash
#echo $PASSWORD | sudo -S mkdir -p /usr/lib/pepflashplugin-installer
#ln -s /usr/lib/pepflashplugin-installer/libpepflashplayer.so /opt/google/chrome/PepperFlash
#echo $PASSWORD | sudo -S ln -s /opt/google/chrome/PepperFlash/libpepflashplayer.so /usr/lib/pepflashplugin-installer
#echo $PASSWORD | sudo -S dpkg-reconfigure pepperflashplugin-nonfree2
#echo $PASSWORD | sudo -S apt-cache policy browser-plugin-freshplayer-pepperflash
#echo $PASSWORD | sudo -S update-pepperflashplugin-nonfree --status
#echo $PASSWORD | sudo -S update-pepperflashplugin-nonfree --install

#echo $PASSWORD | sudo -S dpkg-reconfigure pepperflashplugin-nonfree2
#echo $PASSWORD | sudo -S update-pepperflashplugin-nonfree --status
#echo $PASSWORD | sudo -S update-pepperflashplugin-nonfree --install

#cat /usr/lib/pepperflashplugin-nonfree/etc-chromium-default.txt | echo $PASSWORD | sudo -S tee -a /etc/chromium-browser/default
#CHROMIUM_FLAGS="$CHROMIUM_FLAGS --ppapi-flash-path=/usr/lib/pepflashplugin-installer/libpepflashplayer.so --ppapi-flash-version=$FLASH_VERSION"

#echo $PASSWORD | sudo -S add-apt-repository ppa:jonathonf/pepperflashplugin-nonfree
#echo $PASSWORD | sudo -S apt update
#echo $PASSWORD | sudo -S apt install pepperflashplugin-nonfree -y
echo $PASSWORD | sudo -S update-pepperflashplugin-nonfree --install
echo $PASSWORD | sudo -S update-pepperflashplugin-nonfree --status
#echo $PASSWORD | sudo -S apt install browser-plugin-freshplayer-pepperflash -y
#read r


