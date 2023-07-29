#!/bin/sh
 
# compress all *.jpg files in the current directory 
# and place them in ./compressed directory
# with the same modification date as original files.
#sudo apt-get install jpegoptim

##mkdir compressed && for i in *.jpg; do jpegoptim -d ./compressed -p "$i"; done
##for i in *.jpg; do jpegoptim --dest=./compressed -p "$i"; done
#for i in *.jpg; do jpegoptim --dest=$(pwd)/compressed -p "$i"; done

#cd /tmp
#wget http://www.kokkonen.net/tjko/src/jpegoptim-1.4.4.tar.gz
#tar -xvf jpegoptim*
#cd jpegoptim*
#./configure --prefix=/usr
#make
#sudo make install

sudo apt install jpegoptim


#mkdir $dir && find $(pwd) -type f -iname *.jpg -exec jpegoptim --max=60 -d$(pwd)/$dir/ --all-progressive -p {} \;

cd /tmp
#wget --header='Referer: https://sourceforge.net/projects/optipng/files/OptiPNG/optipng-0.7.6/optipng-0.7.6.tar.gz/download?use_mirror=netcologne&download=' --header='Connection: keep-alive' 'https://netcologne.dl.sourceforge.net/project/optipng/OptiPNG/optipng-0.7.6/optipng-0.7.6.tar.gz' -O 'optipng-0.7.6.tar.gz' -c
wget --header "Host: kumisystems.dl.sourceforge.net" --user-agent "Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0 Waterfox/56.6.2022.11" --header "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" --header "Accept-Language: pl,en-US;q=0.7,en;q=0.3" --referer "https://sourceforge.net/projects/optipng/files/OptiPNG/optipng-0.7.6/optipng-0.7.6.tar.gz/download" --header "Upgrade-Insecure-Requests: 1" "https://kumisystems.dl.sourceforge.net/project/optipng/OptiPNG/optipng-0.7.6/optipng-0.7.6.tar.gz" --output-document "optipng-0.7.6.tar.gz"
tar -xvf optipng*
cd optipng*
./configure --prefix=/usr
make
sudo make install



