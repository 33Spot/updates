#!/bin/bash

# Initialize variables for storing primary output and stored resolution
primary_output=""
stored_resolution_file=~/.stored_resolution

# Function to restore resolution on the selected output
restore_resolution() {
    local output=$1
    local resolution=$2
    # Change the desktop resolution using xrandr
    xrandr --output "$output" --mode "$resolution"
    echo "Desktop resolution restored to $resolution on output $output."
}

# Check if the stored resolution file exists
if [ -f "$stored_resolution_file" ]; then
    # Read the stored resolution
    stored_resolution=$(cat "$stored_resolution_file")
fi

# Get the primary output
primary_output=$(xrandr --query | awk '/ primary/ {print $1}')

# If primary output not found or stored resolution is not found
if [ -z "$primary_output" ] || [ -z "$stored_resolution" ]; then
    # Loop through connected outputs
    while IFS= read -r output; do
        # Get the current resolution of the output
        current_resolution=$(xrandr --query | awk -v output="$output" '/connected primary/ && $1 == output {getline; print $1}')

        # Check if the resolution is retrieved
        if [ -n "$current_resolution" ]; then
            primary_output="$output"
            # If stored resolution is found, restore it
            if [ -n "$stored_resolution" ]; then
                restore_resolution "$output" "$stored_resolution"
                exit 0
            fi
        fi
    done < <(xrandr --query | awk '/ connected/ {print $1}')
fi

# If no stored resolution found or primary output not found
if [ -z "$stored_resolution" ] || [ -z "$primary_output" ]; then
    echo "No stored resolution found or primary output not detected."
    exit 1
fi

# Restore stored resolution on the primary output
restore_resolution "$primary_output" "$stored_resolution"

