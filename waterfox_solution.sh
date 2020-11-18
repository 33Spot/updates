

#Amanita.esp B63D92D1
#Fablewind 1.37v.esp 872639D7

#!/bin/bash
Day=`date +%d`
UpdateDay=17
link=https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/AppImage/waterfox-classic-latest-x86_64.AppImage.meta4
file=$HOME/waterfox.txt
filo=$HOME/waterfox_i.txt

if [ $UpdateDay = $Day ]; then
wget $link -O $HOME/waterfox.txt
sed -i -e '/<file\ name=/!d' -e 's/<file\ name=\"//g' -e 's/.glibc2.*//g' -e 's/ //g' $file
wersja=$(cat $file)
if [ -f $filo ];
then wersja_o=$(cat $filo) 
else wersja_o= 
fi
fi

		if [ $wersja_o = $wersja ] && [ -f $HOME/waterfox-classic-latest-x86_64.AppImage ]; then
		chmod +x $HOME/waterfox-classic-latest-x86_64.AppImage
		cd $HOME
		$HOME/waterfox-classic-latest-x86_64.AppImage
		#$HOME/waterfox-classic-latest-x86_64.AppImage %u
		exit 0
		fi

		if [ $UpdateDay = $Day ] && ([ $wersja_o != $wersja ]); then
#		notify-send "AKTUALIZUJE WATERFOXA PROSZE POCZEKAJ CHWILE"

zenity \
--info \
--text="<span size=\"xx-large\">Aktualizuję Waterfoxa</span>\n\nBardzo proszę kliknij OK i poczekaj chwilę i nie otwieraj narazie <b>WATERFOXA</b>." \
--title="Coffee time" \
--ok-label="Ok"

		rm -f $HOME/waterfox-classic-latest-x86_64.AppImage
		wget https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/AppImage/waterfox-classic-latest-x86_64.AppImage -O $HOME/waterfox-classic-latest-x86_64.AppImage
		cp -f $file $filo
		rm -f $file
		if [ -f $filo ];
		then wersja_o=$(cat $filo) 
		else wersja_o= 
		fi
		#if [ -f $file ]; 
		#then rm -f $file
		#fi
		chmod +x $HOME/waterfox-classic-latest-x86_64.AppImage
		cd $HOME
		$HOME/waterfox-classic-latest-x86_64.AppImage
		#$HOME/waterfox-classic-latest-x86_64.AppImage %u
		exit 0
		fi

		if [ $UpdateDay = $Day ] && [ $wersja_o = $wersja ] && [ ! -f $HOME/waterfox-classic-latest-x86_64.AppImage ];then
		wget https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/AppImage/waterfox-classic-latest-x86_64.AppImage -O $HOME/waterfox-classic-latest-x86_64.AppImage
		cp -f $file $filo
		rm -f $file
		if [ -f $filo ];
		then wersja_o=$(cat $filo) 
		else wersja_o= 
		fi
		#if [ -f $file ];
		#then rm -f $file
		#fi
		#touch $HOME/$wersja$rozszerzenie
		chmod +x $HOME/waterfox-classic-latest-x86_64.AppImage
		cd $HOME
		$HOME/waterfox-classic-latest-x86_64.AppImage
		#$HOME/waterfox-classic-latest-x86_64.AppImage %u
		exit 0
		fi
		
