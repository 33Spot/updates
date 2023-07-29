# identify the disk partition which you want to scan for bad sectors
sudo lsblk -o name,mountpoint,label,size,uuid
sudo fdisk -l
# Scan for Bad Sectors
sudo badblocks -nsv /dev/sda1 > ~/bad_sectors.txt
# Repair Bad Sectors (For ext2, ext3, and ext4 file systems, you can use e2fsck utility)
sudo e2fsck -cfpv /dev/sda1
# You can also specify the bad_sectors.txt file created in the earlier steps as well to force e2fsck to repair those
sudo e2fsck -l bad_sectors.txt /dev/sda1
# For other file systems (such as FAT32), you can use fsck.
sudo fsck -l bad_sectors.txt /dev/sda1

#readarray -t lines < <(lsblk --nodeps -no name,serial,size | grep "sd")
#readarray -t lines < <(lsblk -S --list --nodeps --fs -n --output model,type,serial,size,fstype,fsavail,mountpoint)
IFS=$'\n' read -d '' -ra lines < <(lsblk -S --list --nodeps --fs -n --output model,type,serial,size,fstype,fsavail,mountpoint)


# Prompt the user to select one of the lines.
echo "Please select a drive:"
select choice in "${lines[@]}"; do
  [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
  break # valid choice was made; exit prompt.
done

# Split the chosen line into ID and serial number.
read -r id sn unused <<<"$choice"

echo "id: [$id]; s/n: [$sn]"











#!/bin/bash

# Dynamic Menu Function
createmenu () {
    select selected_option; do # in "$@" is the default
        if [ 1 -le "$REPLY" ] && [ "$REPLY" -le $(($#)) ]; then
            break;
        else
            echo "Please make a vaild selection (1-$#)."
        fi
    done
}

declare -a drives=();
# Load Menu by Line of Returned Command
mapfile -t drives < <(lsblk --nodeps -o name,serial,size | grep "sd");
# Display Menu and Prompt for Input
echo "Available Drives (Please select one):";
createmenu "${drives[@]}"
# Split Selected Option into Array and Display
drive=($(echo "${selected_option}"));
echo "Drive Id: ${drive[0]}";
echo "Serial Number: ${drive[1]}";













#!/bin/bash

# define an array
declare -a obj

# capture the current IFS
cIFS=$IFS

# change IFS to something else
IFS=:

# assign & format output from lsblk 
obj=( $(lsblk --nodeps --no name,serial,size) )

# generate a menu system
select item from ${obj[@]}; do
  if  [ -n ${item} ]; then
    echo "Invalid selection"
    continue
  else
    selection=${item}
    break
  fi
done

# reset the IFS
IFS=${cIFS}







# without readarray for the first script
IFS=$'\n' read -d '' -ra lines < <(lsblk --nodeps -no name,serial,size | grep "sd")





https://www.gnome-look.org/p/1000146





