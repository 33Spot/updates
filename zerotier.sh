#!/bin/env bash
# install_zerotier_dialog.sh
# Interactive installer for ZeroTier using ./xidel and aria2c, with dialog menus.
# Written to be simple, robust, and handle spaces in filenames/paths.
# Requirements: ./xidel (standalone in current dir or in PATH), aria2c, dialog, sudo, dpkg

set -euo pipefail
IFS=$'\n\t'

# --- Helpers -----------------------------------------------------------------
msgbox(){ dialog --title "$1" --msgbox "$2" 12 70; }
errbox(){ dialog --title "Error" --msgbox "$1" 12 70; }
confirm(){ dialog --title "$1" --yesno "$2" 10 60; }

cleanup(){ rm -rf "$TMPDIR" || true; }
trap cleanup EXIT

TMPDIR="$(mktemp -d)"
WORKDIR="$PWD"
XIDEL_CMD="./xidel"
ARIA2C_CMD="aria2c"
DIALOG_CMD="dialog"

# --- Check required commands -------------------------------------------------
missing=()
command -v "$ARIA2C_CMD" >/dev/null 2>&1 || missing+=(aria2c)
command -v "$DIALOG_CMD" >/dev/null 2>&1 || missing+=(dialog)
if ! "$XIDEL_CMD" -v >/dev/null 2>&1 2>/dev/null; then
  # try in PATH as fallback
  if command -v xidel >/dev/null 2>&1; then
    XIDEL_CMD="xidel"
  else
    missing+=(xidel)
  fi
fi

if [ ${#missing[@]} -ne 0 ]; then
  echo "Missing: ${missing[*]}" >&2
  msgbox "Missing tools" "This script requires: ${missing[*]}\n\nPlease install them (e.g. sudo apt install aria2 dialog) and re-run."
  exit 1
fi

# --- Distro codename mapping (FULL Ubuntu ↔ Mint) -------------------------------
# Format: codename|ubuntu_version|mint_version
# NOTE: This map has been cleaned up (de-duplicated, ordered) for clarity.
DIST_MAP=(
  "precise|Ubuntu 12.04 LTS|Linux Mint 13 (Maya)"
#  "trusty|Ubuntu 14.04 LTS|Linux Mint 17 (Qiana), 17.1 (Rebecca), 17.2 (Rafaela), 17.3 (Rosa)"
  "xenial|Ubuntu 16.04 LTS|Linux Mint 18 (Sarah), 18.1 (Serena), 18.2 (Sonya), 18.3 (Sylvia)"
  "trusty|Ubuntu 14.04 LTS|Linux Mint 17 (Qiana), 17.1 (Rebecca), 17.2 (Rafaela), 17.3 (Rosa)"
  "bionic|Ubuntu 18.04 LTS|Linux Mint 19 (Tara), 19.1 (Tessa), 19.2 (Tina), 19.3 (Tricia)"
  "focal|Ubuntu 20.04 LTS|Linux Mint 20 (Ulyana), 20.1 (Ulyssa), 20.2 (Uma), 20.3 (Una)"
  "jammy|Ubuntu 22.04 LTS|Linux Mint 21 (Vanessa), 21.1 (Vera), 21.2 (Victoria), 21.3 (Virginia)"
  "kinetic|Ubuntu 22.10|No Mint release"
  "noble|Ubuntu 24.04 LTS|Linux Mint 22 (Wilma), 22.1 (Xia), 22.2 (Zara)"
)

# --- Functions that query remote site ---------------------------------------
fetch_versions(){
  # Attempts to list subdirectories from RELEASES page and return newline-separated versions
  # Primary: xidel xpath for <a href="<version>/"> links
  # Fallback: curl + grep
  local url="https://download.zerotier.com/RELEASES/"
  set +e
  versions="$($XIDEL_CMD -q "$url" -e "//a[substring(@href,string-length(@href))='/' and matches(@href,'^[0-9]')]/@href" 2>/dev/null || true)"
  set -e

  if [ -z "$versions" ]; then
    # fallback parsing HTML with grep
    versions=$(curl -fsS "$url" 2>/dev/null | grep -Eo '>[[:space:]]*[0-9]+\.[0-9]+(\.[0-9]+)?/' | grep -Eo '[0-9]+\.[0-9]+(\.[0-9]+)?' || true)
  else
    versions=$(echo "$versions" | sed -E 's:/$::' | sed '/^\s*$/d')
  fi

  # Unique and sort by version reverse (latest first)
  echo "$versions" | sort -Vr | uniq
}

fetch_codenames_for_version(){
  local version="$1"
  local url="https://download.zerotier.com/RELEASES/${version}/dist/debian/"
  set +e
  codenames="$($XIDEL_CMD -q "$url" -e "//a[substring(@href,string-length(@href))='/' and matches(@href,'^[a-z]')]/@href" 2>/dev/null || true)"
  set -e
  if [ -z "$codenames" ]; then
    codenames=$(curl -fsS "$url" 2>/dev/null | grep -Eo '>[[:space:]]*[a-z0-9-]+/' | grep -Eo '[a-z0-9-]+' || true)
  else
    codenames=$(echo "$codenames" | sed -E 's:/$::' | sed '/^\s*$/d')
  fi
  echo "$codenames" | uniq
}

find_deb_for(){
  local version="$1"; local codename="$2"; local arch="$3"
  local url_base="https://download.zerotier.com/RELEASES/${version}/dist/debian/${codename}/"
  set +e
  files=$($XIDEL_CMD -q "$url_base" -e "//a/@href" 2>/dev/null || true)
  set -e
  if [ -z "$files" ]; then
    files=$(curl -fsS "$url_base" 2>/dev/null | grep -Eo 'href="[^"]+\.deb"' | sed -E 's/href="//;s/"$//' || true)
  fi
  # Match pattern zerotier-one_${version}_<arch>.deb (arch may be amd64)
  echo "$files" | grep -E "zerotier-one[_-]${version}.*${arch}.*\.deb" || true
}

# --- Main interactive flow --------------------------------------------------
while true; do
  # Fetch versions (may take a second)
  VERSIONS_RAW=$(fetch_versions)
  if [ -z "$VERSIONS_RAW" ]; then
    errbox "Could not fetch version list from download.zerotier.com.\nCheck network or xidel availability."; exit 1
  fi

  # Build dialog menu entries limited to 10 rows; dialog will allow arrowing to see more
  mapfile -t VERSIONS <<<"$(echo "$VERSIONS_RAW")"
  menu_items=()
  idx=1
  for v in "${VERSIONS[@]}"; do
    menu_items+=("$idx" "$v")
    ((idx++))
  done

  choice=$(dialog --clear --cancel-label "Exit" --title "Select ZeroTier version" \
    --menu "Choose a ZeroTier release to install (latest on top). Use arrows/page keys for more." 20 70 10 ${menu_items[@]} 3>&1 1>&2 2>&3) || { clear; echo "Cancelled."; exit 0; }
  selected_version="${VERSIONS[$((choice-1))]}"

  # Confirm selection or go back
  if ! confirm "Confirm" "Selected version: $selected_version\nProceed to choose distribution codename?"; then
    continue
  fi

  # Fetch codenames
  CODES_RAW=$(fetch_codenames_for_version "$selected_version")
  if [ -z "$CODES_RAW" ]; then
    errbox "No debian dist codenames found for version $selected_version. Try another version."; continue
  fi

  # --- MODIFIED SECTION: Sort codenames by Ubuntu version ---
  mapfile -t CODES <<<"$(echo "$CODES_RAW")"
  
  # 1. Create a temporary list with sortable version, codename, and display string
  unsorted_entries=()
  for c in "${CODES[@]}"; do
    ubuntu_version_str=""
    mint_version_str=""
    for m in "${DIST_MAP[@]}"; do
      IFS='|' read -r key ub mint <<<"$m"
      if [ "$key" = "$c" ]; then
        ubuntu_version_str="$ub"
        mint_version_str="$mint"
        break
      fi
    done

    if [ -z "$ubuntu_version_str" ]; then
      # Not found in our map, assign a very low version to sort it to the end
      ubuntu_version_str="Ubuntu 0.00"
      mint_version_str="(no mapping in script)"
    fi
    
    # Extract just the version number for sorting (e.g., "22.04" from "Ubuntu 22.04 LTS")
    sortable_version=$(echo "$ubuntu_version_str" | grep -Eo '[0-9]+\.[0-9]+(\.[0-9]+)?' || echo "0.00")
    
    display_string="$c — $ubuntu_version_str / $mint_version_str"
    unsorted_entries+=("${sortable_version}|${c}|${display_string}")
  done

  # 2. Sort the list by version number (newest first)
  mapfile -t sorted_entries < <(printf '%s\n' "${unsorted_entries[@]}" | sort -Vr)

  # 3. Build the final dialog menu from the sorted data
  codemenu=()
  i=1
  for entry in "${sorted_entries[@]}"; do
    # We only need the display string part for the menu
    IFS='|' read -r _ _ display_string <<< "$entry"
    codemenu+=("$i" "$display_string")
    ((i++))
  done
  # --- END OF MODIFIED SECTION ---

  codemenu+=("back" "<Go back to versions list>")

  codeselect=$(dialog --clear --cancel-label "Back" --title "Select codename" \
    --menu "Choose target codename (shows Ubuntu / Mint hints)." 20 80 10 ${codemenu[@]} 3>&1 1>&2 2>&3) || continue

  if [ "$codeselect" = "back" ]; then
    continue
  fi

  # We need to find the original codename from the sorted list
  selected_entry="${sorted_entries[$((codeselect-1))]}"
  IFS='|' read -r _ selected_codename _ <<< "$selected_entry"


  # Ask for architecture (only amd64 offered by UI but user can type other)
  arch=$(dialog --inputbox "Enter architecture to install (amd64 recommended)" 8 60 "amd64" 3>&1 1>&2 2>&3) || continue

  # Find deb file
  deb_relpath=$(find_deb_for "$selected_version" "$selected_codename" "$arch" | head -n1 || true)
  if [ -z "$deb_relpath" ]; then
    errbox "Could not find a matching .deb file for version ${selected_version}, codename ${selected_codename}, arch ${arch}."; continue
  fi

  # Build full URL
  base_url="https://download.zerotier.com/RELEASES/${selected_version}/dist/debian/${selected_codename}/"
  # If href is absolute, keep it
  if [[ "$deb_relpath" == http* ]]; then
    deb_url="$deb_relpath"
  else
    deb_url="${base_url}${deb_relpath}"
  fi

  # Confirm download
  if ! confirm "Install" "About to download and install:\n$deb_url\n\nInstall now?"; then
    continue
  fi

  # Download using aria2c stealthy and fast
  cd "$TMPDIR"
  $ARIA2C_CMD -q -x16 -s16 --retry-wait=2 --max-tries=5 --allow-overwrite -o "zerotier.deb" "$deb_url" || { errbox "Download failed."; continue; }

  # Install
  sudo dpkg -i zerotier.deb || { 
    sudo apt-get install -f -y && sudo dpkg -i zerotier.deb || { errbox "Installation failed even after fixing deps."; continue; }
  }

  # Ask user to start service
  if dialog --title "Start service" --yesno "ZeroTier installed.

Start and enable zerotier-one service now?" 10 60; then
    sudo systemctl enable --now zerotier-one || errbox "Failed to start service."
  fi

  msgbox "Success" "ZeroTier ${selected_version} installed from ${selected_codename} for arch ${arch}.\n\nYou can enable the service with: sudo systemctl enable --now zerotier-one"
  break

done

# End
clear
echo "Done."
exit 0
