#sudo sed "/GRUB_CMDLINE_LINUX_DEFAULT=/c\GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash fsck.mode=force fsck.repair=yes\"" /etc/default/grub -i
sudo sed "/GRUB_CMDLINE_LINUX_DEFAULT=/c\GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash fsck.mode=auto fsck.repair=yes\"" /etc/default/grub -i
sudo update-grub
#shutdown -rF now
