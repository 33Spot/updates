#USB
#disk=sdc1
#SD
#disk=mmcblk0
#disk=mmcblk0p1
#disk=mmcblk0p1
#disk=mmcblk0p2
disk=sdb1

#sudo apt install gddrescue
#mkdir -p ~/Pulpit/copy_of_Card
#sudo ddrescue /dev/mmcblk0p1 ~/Pulpit/copy_of_Card
#sudo apt install testdisk


sudo umount /dev/$disk
#sudo mount -o remount,rw /dev/$disk
#bash
#sudo fsck -p /dev/$disk

#sudo dosfsck -v /dev/$disk
sudo fsck.fat -a /dev/$disk
#sudo fsck.ext4 -v /dev/$disk
#sudo fsck -v /dev/$disk

#sudo e2fsck -n /dev/$disk

#sudo e2fsck -b 8193 /dev/$disk
#sudo e2fsck -b 32768 /dev/$disk
#sudo mke2fs -n /dev/$disk
#sudo fsck -b 32768 -B 406 /dev/$disk
bash

