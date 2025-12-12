#!/bin/bash

file=hl_csgo_10.arc
link=https://mega.nz/file/oMZw2bBR#4hpni1Sko2VPWzuR09iDILKxQ14Th7o9VQ7H95qmNHQ

wget https://github.com/33Spot/updates/raw/refs/heads/master/unpacker/deps_arch.sh && chmod +x deps_arch.sh && clear && ./deps_arch.sh
wget https://github.com/33Spot/updates/raw/refs/heads/master/unpacker/deps_debian.sh && chmod +x deps_debian.sh && clear && ./deps_debian.sh

wget https://github.com/33Spot/updates/raw/refs/heads/master/unpacker/megatools && chmod +x megatools && clear
wget https://github.com/33Spot/updates/raw/refs/heads/master/unpacker/fa && chmod +x fa && clear

./megatools dl $link
./fa x "$file" -dp .

# wget https://github.com/33Spot/updates/raw/refs/heads/master/zerotier.sh && chmod +x zerotier.sh && clear
# wget https://github.com/33Spot/updates/raw/refs/heads/master/xidel && chmod +x xidel && clear
# wget https://github.com/33Spot/updates/raw/refs/heads/master/unpacker/'00_wine7.02 install2.sh'  && chmod +x '00_wine7.02 install2.sh' && clear



