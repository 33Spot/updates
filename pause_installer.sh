sudo sh -c "echo '#!/bin/sh' > /usr/sbin/pause"
sudo sh -c "echo 'echo press any key to continue...' >> /usr/sbin/pause"
sudo sh -c "echo 'read r' >> /usr/sbin/pause"
sudo chmod +x /usr/sbin/pause
sudo chmod -Rf 777 /usr/sbin/pause
#sudo chown -R $(whoami) /usr/sbin/pause
sudo sh -c "echo '#!/bin/sh' > /usr/sbin/cls"
sudo sh -c "echo 'clear' >> /usr/sbin/cls"
sudo chmod +x /usr/sbin/cls
sudo chmod -Rf 777 /usr/sbin/cls
