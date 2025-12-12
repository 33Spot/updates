#!/usr/bin/env bash

# Function to display available versions and prompt selection
select_wine_version() {
    available_versions=$(apt-cache madison winehq-stable | awk '{print $3}')
    if [ -z "$available_versions" ]; then
        echo "No available Wine versions found."
        exit 1
    fi

    # Create dialog menu options dynamically
    menu_options=()
    for version in $available_versions; do
        menu_options+=("$version" "Install version $version")
    done

    # Show dialog to select a version
    chosen_version=$(dialog --clear --stdout --title "Wine Version Selection" \
        --menu "Choose Wine version to install:" 15 50 8 "${menu_options[@]}")

    if [ -z "$chosen_version" ]; then
        echo "No version selected. Exiting..."
        exit 1
    fi
    clear
    echo "Selected Wine version: $chosen_version"
}


# Run the version selection function
select_wine_version

# Begin installation steps
echo "Setting up Wine installation for version: $chosen_version"
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add /etc/apt/keyrings/winehq-archive.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources

sudo apt-get update

# Stop Wine if running
if ps aux | grep wine > /dev/null
then
  echo "wine is running"
#    pkill wine
else
  echo "wine is not running"
fi


# Uninstall existing Wine versions
sudo apt-mark unhold wine-stable wine-stable-amd64 wine-stable-i386 winehq-stable
sudo apt remove -y winehq-stable wine-stable wine-stable-amd64 wine-stable-i386

# Install selected Wine version
sudo apt-get install wine-stable-amd64="$chosen_version" -y
sudo apt-get install wine-stable-i386="$chosen_version" -y
sudo apt-get install wine-stable="$chosen_version" -y
sudo apt-get install winehq-stable="$chosen_version" -y

# Additional required packages
sudo apt-get install libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 \
    libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386

# Install winetricks
sudo apt-get install winetricks -y

# Install Wine Mono and Gecko




# Fetch the list of available Wine Mono versions
#curl -s "$MONO_URL" | grep -oP 'wine-mono-\K[0-9]+\.[0-9]+\.[0-9]+' | sort -u > "$TEMP_FILE"
./xidel "https://dl.winehq.org/wine/wine-mono/" -e '(//@href, //@src)/resolve-uri(.)' | grep "https://dl.winehq.org/wine/wine-mono/" | sed 's/https\:\/\/dl\.winehq\.org\/wine\/wine-mono\///g' | grep -v "C=" | sed 's/\///g' | tac > ./mono_versions.txt

# Build dialog options from fetched versions
declare -a optionsmono
while IFS= read -r versionmono; do
  optionsmono+=("$versionmono" "Wine Mono $versionmono")
done < ./mono_versions.txt

# Display dialog for selecting a version
clear
choicemono=$(dialog --menu "Select Wine Mono version to install" 15 50 8 "${optionsmono[@]}" 3>&1 1>&2 2>&3)

# Install the selected version if user made a choice
clear
if [ -n "$choicemono" ]; then
  echo "Selected Wine Mono version: $choicemono"
sudo mkdir -p /opt/wine-stable/share/wine/mono
sudo wget -O - "https://dl.winehq.org/wine/wine-mono/"$choicemono"/wine-mono-"$choicemono"-x86.tar.gz" | sudo tar -xJv -C /opt/wine-stable/share/wine/mono
sudo wget -O - "https://dl.winehq.org/wine/wine-mono/"$choicemono"/wine-mono-"$choicemono"-x86.tar.xz" | sudo tar -xJv -C /opt/wine-stable/share/wine/mono
  echo "Downloaded Wine Mono version $choicemono to ~/Downloads."
else
  echo "No version selected. Exiting."
fi

# Clean up
rm -f ./mono_versions.txt












# Fetch the list of available Wine Mono versions
#curl -s "$MONO_URL" | grep -oP 'wine-mono-\K[0-9]+\.[0-9]+\.[0-9]+' | sort -u > "$TEMP_FILE"
./xidel "https://dl.winehq.org/wine/wine-gecko/" -e '(//@href, //@src)/resolve-uri(.)' | grep "https://dl.winehq.org/wine/wine-gecko/" | sed 's/https\:\/\/dl\.winehq\.org\/wine\/wine-gecko\///g' | grep -v "C=" | sed 's/\///g' | tac > ./gecko_versions.txt

# Build dialog options from fetched versions
declare -a optionsgecko
while IFS= read -r versiongecko; do
  optionsgecko+=("$versiongecko" "Wine Gecko $version")
done < ./gecko_versions.txt

# Display dialog for selecting a version
clear
choicegecko=$(dialog --menu "Select Wine Mono version to install" 15 50 8 "${optionsgecko[@]}" 3>&1 1>&2 2>&3)

# Install the selected version if user made a choice
clear
if [ -n "$choicegecko" ]; then
  echo "Selected Wine Gecko version: $choicegecko"


sudo mkdir -p /opt/wine-stable/share/wine/gecko
sudo wget -O "/opt/wine-stable/share/wine/gecko/wine-gecko-"$choicegecko"-x86.msi" "https://dl.winehq.org/wine/wine-gecko/"$choicegecko"/wine-gecko-"$choicegecko"-x86.msi"
sudo wget -O "/opt/wine-stable/share/wine/gecko/wine-gecko-"$choicegecko"-x86_64.msi" "https://dl.winehq.org/wine/wine-gecko/"$choicegecko"/wine-gecko-"$choicegecko"-x86_64.msi"
sudo wget -O "/opt/wine-stable/share/wine/gecko/wine-gecko-"$choicegecko"-x86_64.msi" "https://dl.winehq.org/wine/wine-gecko/"$choicegecko"/wine-gecko-"$choicegecko".tar.bz2"

  echo "Downloaded Wine Gecko version $choicegecko to ~/Downloads."
else
  echo "No version selected. Exiting."
fi

# Clean up
rm -f ./gecko_versions.txt






# Hold the selected version to prevent updates
sudo apt-mark hold wine-stable wine-stable-amd64 wine-stable-i386 winehq-stable

# Display installed version
winecfg
echo "Wine installation complete."

# Check for latest version of winetricks
echo "Latest version of winetricks is:"
curl --silent --show-error https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks --stderr - \
    | grep ^WINETRICKS_VERSION | cut -d '=' -f 2

sudo apt-get remove winetricks -y
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
sudo mv -v winetricks /usr/bin
winetricks --version
sudo update-alternatives --install /usr/bin/wine wine /opt/wine-stable/bin/wine 100
#sudo update-alternatives --auto wine
update-alternatives --get-selections
update-alternatives --display wine
sudo update-alternatives --config wine
#sudo update-alternatives --remove-all wine






