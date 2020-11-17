#!/bin/bash
# File that stores the last execution date in plain text:
datefile=$HOME/datefile.txt
if [ -f $(echo $datefile) ]; then
echo ""
else 
	echo $(date) >$datefile 
fi


# Minimum delay between two script executions, in seconds. 
seconds=$((60*60*24*30))


# Test if datefile exists and compare the difference between the stored date 
# and now with the given minimum delay in seconds. 
# Exit with error code 1 if the minimum delay is not exceeded yet.
if test -f "$datefile" ; then
    if test "$(($(date "+%s")-$(date -f "$datefile" "+%s")))" -lt "$seconds" ; then
        #echo "This script may not yet be started again."
		#rf -f $HOME/waterfox-classic-latest-x86_64.AppImage
		if [ -f $HOME/waterfox-classic-latest-x86_64.AppImage ]; then
		chmod +x $HOME/waterfox-classic-latest-x86_64.AppImage
		cd $HOME
		./waterfox-classic-latest-x86_64.AppImage
		else
		wget https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/AppImage/waterfox-classic-latest-x86_64.AppImage -O $HOME/waterfox-classic-latest-x86_64.AppImage
		chmod +x $HOME/waterfox-classic-latest-x86_64.AppImage
		cd $HOME
		./waterfox-classic-latest-x86_64.AppImage
		#$HOME/waterfox-classic-latest-x86_64.AppImage
		fi
        
        exit 1
    fi
    rf -f $HOME/waterfox-classic-latest-x86_64.AppImage
fi


