flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.usebottles.bottles
flatpak override --user --filesystem=/mnt/Transcend com.usebottles.bottles
flatpak run com.usebottles.bottles
