
password=qaz123

gdebi=dpkg\ \-\-force-all\ \-i


#./xidel -e '(//@href, //@src)/resolve-uri(.)' https://www.xnview.com/en/xnviewmp/


url_p=$(curl -s -L http://www.xnview.com/en/xnviewmp/|sed -n -E '/Version/{s/.*Version ([\.0-9]+).*/\1/;s/\.//;p;q;}' | sed 's/\.//g')
echo $url_p
echo press enter to download...
read r


url=https://download.xnview.com/XnViewMP-linux-x64.deb
debpackage=XnViewMP-linux-x64.deb
package=./$debpackage
if [ ! -f $package ]; then
(
wget --no-check-certificate $url
echo $password | sudo -S $gdebi $package
)
fi

if [ -f $package ]; then
(
rm -f $package wget-log
)
fi



#./xidel -e '(//@href, //@src)/resolve-uri(.)' https://www.torproject.org/download/alpha/ | grep "linux64" | sed '/\.asc/d'
url_p=$(./xidel -e '(//@href, //@src)/resolve-uri(.)' https://www.torproject.org/download/alpha/ | grep "linux64" | sed '/\.asc/d')
echo $url_p
echo press enter to download...
read r



#url=$(./xidel -e '(//@href, //@src)/resolve-uri(.)' https://www.waterfox.net/download/ | grep "\.tar")
#debpackage=${url##*/}
#package=./$debpackage
#if [ ! -f $package ]; then
#(
#wget --no-check-certificate $url
##echo $password | sudo -S $gdebi $package
#tar
#)
#fi
#
#if [ -f $package ]; then
#(
#rm -f $package wget-log
#)
#fi



#url_p=$(./xidel -e '(//@href, //@src)/resolve-uri(.)' https://github\.com/abbodi1406/vcredist/releases | grep "releases/expanded" | head -n 1)
#url=https://github.com$(wget -qO- $url_p | grep ".zip" | sed -e "/span/d" -e "/FreetubeApp/,/deb/p" | sed -n '/"/!{/\n/{P;b}};s/"/\n/g;D' | head -n 1)
#debpackage=${url##*/}
#package=./$debpackage
#echo $password | sudo -S gdebi $package
#if [ ! -f $package ]; then
#(
#wget $url
#unzip $package && rm -f $package
#)
#fi
#
#if [ -f $package ]; then
#(
#rm -f $package
#)
#fi




url_p=$(./xidel -e '(//@href, //@src)/resolve-uri(.)' https://download.anydesk.com/linux/ | sed '/\.sum/d' | grep "_amd64.deb" | grep "linux/anydesk" | tail -n 1)
echo $url_p
echo press enter to download...
read r



url=$(./xidel -e '(//@href, //@src)/resolve-uri(.)' https://download.anydesk.com/linux/ | sed '/\.sum/d' | grep "_amd64.deb" | grep "linux/anydesk" | tail -n 1)
debpackage=${url##*/}
package=./$debpackage
if [ ! -f $package ]; then
(
wget --no-check-certificate $url
echo $password | sudo -S $gdebi $package
)
fi

if [ -f $package ]; then
(
rm -f $package wget-log
)
fi


url_p=$(./xidel -e '(//@href, //@src)/resolve-uri(.)' https://github\.com/FreeTubeApp/FreeTube/releases | grep "releases/expanded" | head -n 1)
echo $url_p
echo press enter to download...
read r

#url=https://github.com$(wget -qO- 'https://github.com/FreeTubeApp/FreeTube/releases/latest' | grep "amd64.deb" | sed -e "/span/d" -e "/FreetubeApp/,/deb/p" | sed -n '/"/!{/\n/{P;b}};s/"/\n/g;D' | head -n 1)
url_p=$(./xidel -e '(//@href, //@src)/resolve-uri(.)' https://github\.com/FreeTubeApp/FreeTube/releases | grep "releases/expanded" | head -n 1)
url=https://github.com$(wget -qO- $url_p | grep "amd64.deb" | sed -e "/span/d" -e "/FreetubeApp/,/deb/p" | sed -n '/"/!{/\n/{P;b}};s/"/\n/g;D' | head -n 1)
rm -f index.html
debpackage=${url##*/}
package=./$debpackage
if [ ! -f $package ]; then
(
wget --no-check-certificate $url
echo $password | sudo -S $gdebi $package
)
fi

if [ -f $package ]; then
(
rm -f $package wget-log
)
fi



url_p=$(./xidel -e '(//@href, //@src)/resolve-uri(.)' https://github\.com/ferdium/ferdium-app/releases | grep "releases/expanded" | head -n 1)
url=https://github.com$(wget -qO- $url_p | grep "amd64.deb" | sed -e "/span/d" -e "/ferdium/,/deb/p" | sed -n '/"/!{/\n/{P;b}};s/"/\n/g;D' | head -n 1)
echo $url
echo press enter to download...
read r


url_p=$(./xidel -e '(//@href, //@src)/resolve-uri(.)' https://github\.com/ferdium/ferdium-app/releases | grep "releases/expanded" | head -n 1)
url=https://github.com$(wget -qO- $url_p | grep "amd64.deb" | sed -e "/span/d" -e "/ferdium/,/deb/p" | sed -n '/"/!{/\n/{P;b}};s/"/\n/g;D' | head -n 1)
rm -f index.html
debpackage=${url##*/}
package=./$debpackage
if [ ! -f $package ]; then
(
wget --no-check-certificate $url
echo $password | sudo -S $gdebi $package
)
fi

if [ -f $package ]; then
(
rm -f $package wget-log
)
fi






#url_p=$(./xidel -e '(//@href, //@src)/resolve-uri(.)' https://github\.com/ferdium/ferdi/releases | grep "releases/expanded" | head -n 1)
#url=https://github.com$(wget -qO- $url_p | grep "amd64.deb" | sed -e "/span/d" -e "/ferdi/,/deb/p" | sed -n '/"/!{/\n/{P;b}};s/"/\n/g;D' | head -n 1)
#rm -f index.html
#debpackage=${url##*/}
#package=./$debpackage
##echo $password | sudo -S $gdebi $package
#if [ ! -f $package ]; then
#(
#wget --no-check-certificate $url
#echo $password | sudo -S $gdebi $package
#)
#fi
#
#if [ -f $package ]; then
#(
##rm -f $package wget-log
#)
#fi





#wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | echo $password | sudo -S apt-key add -
#echo "deb http://deb.anydesk.com/ all main" | echo $password | sudo -S tee /etc/apt/sources.list.d/anydesk-stable.list
#echo $password | sudo -S apt update
#echo $password | sudo -S apt install xsel

echo done!
#read r;



