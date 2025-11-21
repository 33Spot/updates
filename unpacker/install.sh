#!/bin/bash

file=hl_csgo_10.arc
link=https://mega.nz/file/ENhGHSjK#qqcDlRy9-DuzD9dP1_od2FN2wbzOKs6cJnAcU64y1c4

wget https://github.com/33Spot/updates/raw/refs/heads/master/unpacker/megatools && chmod +x megatools
wget https://github.com/33Spot/updates/raw/refs/heads/master/unpacker/fa && chmod +x fa

clear
./megatools dl $link

# Function to extract archive and update progress
extract_archive() {
    local archive_file="$1"
    local output_dir="$2"
    local temp_fifo=$(mktemp -u) # Create a unique temporary FIFO name
    mkfifo "$temp_fifo"          # Create the FIFO

    # Extract archive in the background
    (
        ./fa x "$archive_file" -dp"$output_dir" | \
        while read -r line; do
            if [[ $line =~ ([0-9]+)% ]]; then
                local progress=${BASH_REMATCH[1]}
                echo $progress > "$temp_fifo"
            fi
        done
    ) &

    # Display progress bar and handle cancel
    (
        trap "killall fa; rm -f $temp_fifo; exit 1" SIGTERM SIGINT
        dialog --title "Extracting Archive" --gauge "Extracting..." 10 70 < "$temp_fifo"
        rm "$temp_fifo" # Clean up the FIFO
        if [ $? -eq 0 ]; then
            dialog --msgbox "Extraction completed successfully!" 6 50
        else
            dialog --msgbox "Extraction failed or cancelled!" 6 50
        fi
    ) &
    dialog_pid=$!

    wait $dialog_pid
}

# Select the archive file
archive_file=$(zenity --file-selection --title="Select Archive File" --file-filter="*.arc")

# Check if a file was selected
if [[ -z "$archive_file" ]]; then
    zenity --error --text="No archive file selected!"
    exit 1
fi

# Select the output directory
output_dir=$(zenity --file-selection --directory --title="Select Output Directory")

# Check if a directory was selected
if [[ -z "$output_dir" ]]; then
    zenity --error --text="No output directory selected!"
    exit 1
fi

# Start the extraction process
extract_archive "$archive_file" "$output_dir"

