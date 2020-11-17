
#Amanita.esp B63D92D1
#Fablewind 1.37v.esp 872639D7

#!/bin/bash
link=https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/AppImage/waterfox-classic-latest-x86_64.AppImage.meta4
wget $link -O $HOME/waterfox.txt
sed -e '/<file\ name=/!d' -e 's/<file\ name=\"//g' -e 's/.glibc2.*//g' ./waterfox.txt
pause


		Day=`date +%d`
		UpdateDay=17

		if [ $UpdateDay==$Day ] && [ -f $HOME/$wersja$rozszerzenie ]; then
		chmod +x $HOME/waterfox-classic-latest-x86_64.AppImage
		cd $HOME
		$HOME/waterfox-classic-latest-x86_64.AppImage
		fi
		if [ $UpdateDay==$Day ] && !([ -f $HOME/$wersja$rozszerzenie ]); then
#		notify-send "AKTUALIZUJE WATERFOXA PROSZE POCZEKAJ CHWILE"
zenity \
--info \
--text="<span size=\"xx-large\">Aktualizuję Waterfoxa</span>\n\nBardzo proszę poczekaj chwilę i nie otwieraj narazie <b>WATERFOXA</b>." \
--title="Coffee time" \
--ok-label="DOBRA"
		rm -f $HOME/waterfox-classic-latest-x86_64.AppImage
		wget https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/AppImage/waterfox-classic-latest-x86_64.AppImage -O $HOME/waterfox-classic-latest-x86_64.AppImage
		echo "">$HOME/$wersja$rozszerzenie
		chmod +x $HOME/waterfox-classic-latest-x86_64.AppImage
		cd $HOME
		$HOME/waterfox-classic-latest-x86_64.AppImage
		fi
		if !([ -f $HOME/waterfox-classic-latest-x86_64.AppImage ]);	
		wget https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/AppImage/waterfox-classic-latest-x86_64.AppImage -O $HOME/waterfox-classic-latest-x86_64.AppImage
		echo "">$HOME/$wersja$rozszerzenie
		chmod +x $HOME/waterfox-classic-latest-x86_64.AppImage
		cd $HOME
		$HOME/waterfox-classic-latest-x86_64.AppImage]
		fi
		