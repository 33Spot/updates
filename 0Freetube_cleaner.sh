#!/bin/bash
OIFS="$IFS"
IFS=$'\n'
# Declare an array of string with type
declare -a foldery_usun=("blob_storage" "Cache" "Code Cache" "Crashpad" "dashFiles" "DawnCache" "Dictionaries" "GPUCache" "Local Storage" "Session Storage" "storyboards" "WebStorage")


# Iterate the string array using for loop
for val in ${foldery_usun[@]}; do
 echo $val
 rm -r $val
done

# Declare an array of string with type
declare -a pliki_usun=("TransportSecurity" "Cookies-journal" "Network Persistent State" "Cookies")


# Iterate the string array using for loop
for val in ${pliki_usun[@]}; do
 echo $val
 rm -f $val
done

