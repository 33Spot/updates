sudo apr install figlet toilet
git clone https://github.com/DoseOfGose/figlet-fonts
cd figlet-fonts
# from the repo root directory
sudo cp "./fonts/*" "$(figlet -I 2)"
#figlet -I 2
rm -fR figlet-fonts
