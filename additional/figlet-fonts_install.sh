sudo apt install git figlet toilet
git clone https://github.com/DoseOfGose/figlet-fonts
cd figlet-fonts
#cd fonts
# from the repo root directory
sudo cp -r fonts "$(figlet -I 2)"
#figlet -I 2
cd ..
rm -fR figlet-fonts
