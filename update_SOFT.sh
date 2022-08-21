

gdebi=dpkg\ \-\-force-all\ \-i 

url=https://download.xnview.com/XnViewMP-linux-x64.deb
debpackage=XnViewMP-linux-x64.deb
package=./$debpackage
sudo gdebi $package
if [ ! -f $package ]; then
(
wget $url
sudo $gdebi $package
)
fi

if [ -f $package ]; then
(
rm -f $package
)
fi



url=https://github.com$(wget -qO- 'https://github.com/FreeTubeApp/FreeTube/releases/latest' | grep "amd64.deb" | sed -e "/span/d" -e "/FreetubeApp/,/deb/p" | sed -n '/"/!{/\n/{P;b}};s/"/\n/g;D' | head -n 1)
debpackage=${url##*/}
package=./$debpackage
sudo gdebi $package
if [ ! -f $package ]; then
(
wget $url
sudo $gdebi $package
)
fi

if [ -f $package ]; then
(
rm -f $package
)
fi


wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update

sudo apt install xsel

echo done!
#read r;

