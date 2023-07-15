printf "RESUME=UUID=$(blkid | awk -F\" '/swap/ {print $2}')\n" | sudo tee /etc/initramfs-tools/conf.d/resume
sudo update-initramfs -u -k all
