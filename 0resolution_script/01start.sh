#!/bin/bash

# Copy the script to /usr/local/bin
#sudo cp restore_resolution_script.sh /usr/local/bin

# Set appropriate permissions
#sudo chmod +x /usr/local/bin/restore_resolution_script.sh



sudo ./quick_gui_installer.sh ./restore_resolution_script2.sh /usr/local/bin
./configure_xbindkeys.sh /usr/local/bin/restore_resolution_script2.sh
echo "Script installed successfully."
