curl -s https://install.zerotier.com | sudo bash
gdebi=dpkg\ \-\-force-all\ \-i
sudo $gdebi ZeroTier-GUI.deb
# Day of Defeat Central LAN Network
sudo zerotier-cli join 8bd5124fd672f72a
# Mega Games Hub
sudo zerotier-cli join 52b337794fe8c551
sudo zerotier-gui
