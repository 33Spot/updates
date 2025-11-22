#!/usr/bin/env bash
#https://portable-linux-apps.github.io/apps.html
sudo apt install coreutils curl grep sed wget sudo -y
#sudo pacman -S fuse3 coreutils zenity dialog
sudo pacman -S coreutils curl grep sed wget sudo


sudo rm -f /usr/local/bin/am
sudo rm -f /opt/am/APP-MANAGER
sudo rm -f /opt/am/APP-MANAGER.*

# Define the snippet
snippet='if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi'

# File to update
bashrc_file="$HOME/.bashrc"

# Check if the snippet already exists
if grep -Fq 'PATH="$HOME/.local/bin:$PATH"' "$bashrc_file"; then
    echo "Snippet already exists in $bashrc_file"
else
    echo "Adding snippet to $bashrc_file"
    echo -e "\n$snippet" >> "$bashrc_file"
    echo "Snippet added."
fi

#wget https://github.com/ivan-hc/AM/raw/refs/heads/main/AM-INSTALLER --output-document=0AMinstall_i.sh
wget https://github.com/ivan-hc/AM/raw/refs/heads/main/INSTALL --output-document=0AMinstall_i.sh
chmod +x ./0AMinstall_i.sh
sudo ./0AMinstall_i.sh
rm -f ./0AMinstall_i.sh
#/home/spot/.local/bin




