#sudo add-apt-repository ppa:oibaf/test
#sudo apt update
#sudo apt install nohang
git clone https://github.com/hakavlad/nohang.git && cd nohang
deb/build.sh
cd ..
sudo dpkg -i ./nohang/deb/package.deb
sudo systemctl enable --now nohang-desktop.service
rm -rf nohang
sudo systemctl enable --now nohang-desktop.service
systemctl status nohang-desktop
echo done!
read r
