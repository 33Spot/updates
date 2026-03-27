# Stop systemd-resolved

#sudo systemctl stop systemd-resolved && sudo systemctl disable systemd-resolved

#sudo systemctl enable systemd-resolved && sudo systemctl start systemd-resolved



# Remove the symlink it creates
#sudo rm /etc/resolv.conf

# Create a new resolv.conf (use your preferred DNS)

#echo "nameserver 192.168.195.46" | sudo tee /etc/resolv.conf
#echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf

sudo sh -c "echo 'nameserver 192.168.195.46' >> /etc/resolv.conf" && sudo sh -c "echo 'nameserver 8.8.8.8' >> /etc/resolv.conf"

# Now start dnsmasq
#sudo systemctl restart dnsmasq
