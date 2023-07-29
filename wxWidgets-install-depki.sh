sudo apt install g++
sudo apt install libgtk2.0-dev
sudo apt install libcurl4-openssl-dev
sudo apt install libgl1-mesa-dev
sudo apt install libegl1-mesa-dev
sudo apt install libglu1-mesa-dev
sudo apt install libsndfile1-dev
sudo apt install subversion
sudo apt-get install libgtk-3-dev
#sudo apt-get install libgtk2.0-dev
#sudo ln -s /usr/lib/x86_64-linux-gnu/mesa/libGL.so.1 /usr/lib/libGL.so
sudo ln -s /usr/lib/x86_64-linux-gnu/libGL.so.1 /usr/lib/libGL.so
sudo ln -s /usr/lib/x86_64-linux-gnu/libEGL.so.1 /usr/lib/libEGL.so
tar xfv wxWidgets-3.2.1.tar.bz2
cd wxWidgets-3.2.1
make clean
make distclean
mkdir buildgtk
cd buildgtk
#../configure --with-gtk
#make -j $(grep processor /proc/cpuinfo | wc -l)
#sudo make install
../configure --enable-debug --with-gtk=3
make
sudo make install

sudo ldconfig

echo done!
#sudo update-alternatives --config wx-config
bash


