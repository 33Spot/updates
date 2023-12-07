sudo apt-get install smbclient
sudo apt install tracker
sudo mkdir -p /var/lib/samba/usershares/
sudo chmod go+rwx /var/lib/samba/usershares/
sudo usermod -aG sambashare $USER
