#sudo add-apt-repository ppa:oibaf/test
#sudo apt update
#sudo apt install nohang
#sudo systemctl enable --now nohang-desktop.service
git clone https://github.com/hakavlad/nohang.git && cd nohang
deb/build.sh
sudo dpkg -i ./nohang/deb/package.deb
sudo systemctl enable --now nohang-desktop.service
rm -rf nohang
echo done!
read r
