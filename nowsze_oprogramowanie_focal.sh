
#linux_ver=xenial
#linux_ver2=trusty
#linux_ver=focal
linux_ver=$(cat /etc/os-release | grep "UBUNTU_CODENAME" | sed "s/UBUNTU_CODENAME\=//g")

if [ $linux_ver = "focal" ]; then



#sudo add-apt-repository 'deb http://archive.getdeb.net/ubuntu wily-getdeb games'


###### Ubuntu Main Repos
#sudo sh -c 'echo "deb http://pl.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list'
#sudo sh -c 'echo "deb-src http://pl.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list'

###### Ubuntu Update Repos
sudo sh -c 'echo "deb http://pl.archive.ubuntu.com/ubuntu/ '$(echo $linux_ver)'-security main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list'
sudo sh -c 'echo "deb http://pl.archive.ubuntu.com/ubuntu/ '$(echo $linux_ver)'-updates main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list'
sudo sh -c 'echo "deb-src http://pl.archive.ubuntu.com/ubuntu/ '$(echo $linux_ver)'-security main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list'
sudo sh -c 'echo "deb-src http://pl.archive.ubuntu.com/ubuntu/ '$(echo $linux_ver)'-updates main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list'







###### Ubuntu Partner Repo
#sudo sh -c 'echo "deb http://archive.canonical.com/ubuntu '$(echo $linux_ver)' partner" >> /etc/apt/sources.list.d/official-package-repositories.list'
#sudo sh -c 'echo "deb-src http://archive.canonical.com/ubuntu '$(echo $linux_ver)' partner" >> /etc/apt/sources.list.d/official-package-repositories.list'

#sudo add-apt-repository ppa:ubuntu-desktop/ppa
#sudo apt-get update




#sudo cp /etc/apt/sources.list.d/official-package-repositories.list ./official-package-repositories.list

#sudo sh -c 'echo "deb http://packages.linuxmint.com sonya main upstream import" >> /etc/apt/sources.list.d/official-package-repositories.list'
#sudo sh -c 'echo "deb http://extra.linuxmint.com sonya main" >> /etc/apt/sources.list.d/official-package-repositories.list'

#sudo add-apt-repository ppa:ubuntu-desktop/ppa -y
#sudo apt-get update


#wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
#sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu '$(echo $linux_ver)'-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
#wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
#sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu $(echo $linux_ver)-getdeb games" >> /etc/apt/sources.list.d/getdeb.list'


#sudo sh -c 'echo "deb http://archive.canonical.com/ubuntu/ '$(echo $linux_ver)' partner" >> /etc/apt/sources.list.d/official-package-repositories.list'
#wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -


#Repos: Active apt sources in file: /etc/apt/sources.list.d/official-package-repositories.list
#deb http://packages.linuxmint.com rosa main upstream import
#deb http://extra.linuxmint.com rosa main
#deb http://archive.ubuntu.com/ubuntu trusty main restricted universe multiverse
#deb http://archive.ubuntu.com/ubuntu trusty-updates main restricted universe multiverse
#deb http://security.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse
#deb http://archive.canonical.com/ubuntu/ trusty partner
#deb http://packages.linuxmint.com sylvia main upstream import backport #id:linuxmint_main
#sudo sh -c 'echo "deb http://packages.linuxmint.com sylvia main upstream import backport #id:linuxmint_main" >> /etc/apt/sources.list.d/official-package-repositories.list'
#sudo sh -c 'echo "deb http://packages.linuxmint.com sonia main upstream import backport #id:linuxmint_main" >> /etc/apt/sources.list.d/official-package-repositories.list'

sudo sh -c 'echo "deb http://archive.ubuntu.com/ubuntu '$(echo $linux_ver)' main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list'
sudo sh -c 'echo "deb http://archive.ubuntu.com/ubuntu '$(echo $linux_ver)'-updates main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list'
#sudo sh -c 'echo "deb http://archive.ubuntu.com/ubuntu '$(echo $linux_ver)'-backports main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list'
sudo sh -c 'echo "deb http://security.ubuntu.com/ubuntu/ '$(echo $linux_ver)'-security main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list'

#echo "qaz123" | sudo -S cp /etc/apt/sources.list ./sources.list_ >/dev/null 2>/dev/null
#cat -n ./sources.list_  >/dev/null 2>/dev/null | sort -k2 -k1n  | uniq -f1 | sort -nk1,1 | cut -f2- > ./sources.list >/dev/null 2>/dev/null
#echo "qaz123" | sudo -S mv ./sources.list_ /etc/apt/sources.list >/dev/null 2>/dev/null
#rm ./sources.list >/dev/null 2>/dev/null

#sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu '$(echo $linux_ver)'-getdeb apps " >> /etc/apt/sources.list.d/getdeb.list'
#sudo sh -c 'echo "deb http://mirrors.dotsrc.org/getdeb/ubuntu '$(echo $linux_ver)'-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
#sudo sh -c 'echo "deb http://mirrors.dotsrc.org/getdeb/ubuntu '$(echo $linux_ver)'-getdeb games" >> /etc/apt/sources.list.d/getdeb.list'
#sudo sh -c 'echo "deb http://mirrors.dotsrc.org/getdeb/ubuntu lucid-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
#sudo sh -c 'echo "deb-src http://mirrors.dotsrc.org/getdeb/ubuntu lucid-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
#sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com A8A515F046D7E7CF
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A8A515F046D7E7CF
sudo apt-get update


#wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
#sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'



katalog=/etc/apt/sources.list.d
katalog2=$(pwd)
#${0%/*}
mkdir listy 2> /dev/null
#mkdir listy1 2> /dev/null
#mkdir listy2 2> /dev/null
#mkdir listy3 2> /dev/null

cd $katalog
for file in *.list
do
echo Usuwam duplikaty z listy: $file
cat -n $file | sort -k2 -k1n  | uniq -f1 | sort -nk1,1 | cut -f2- > "$katalog2/listy/$file"
#sudo sed -nr '$!N;/^(.*)\n\1$/!P;D'<"$katalog/$file">"$katalog2/listy2/$file"
#cat $file | sort -u > "$katalog2/listy3/$file"
sudo -S mv "$katalog2/listy/$file" "$katalog/$file"
done
rm -r "$katalog2/listy"
sudo apt-get update
fi


