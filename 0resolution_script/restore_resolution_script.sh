#!/bin/bash

# Check if xrandr and xdpyinfo are installed
if ! command -v xrandr &> /dev/null || ! command -v xdpyinfo &> /dev/null; then
    echo "Error: Required utilities (xrandr and/or xdpyinfo) not found."
    exit 1
fi

# Check if the stored resolution file exists
if [ -f ~/.stored_resolution ]; then
    # Read the stored resolution
    resolution=$(cat ~/.stored_resolution)

    # Initialize variables for storing output name and maximum resolution
    max_resolution=""
    primary_output=""

    # Loop through connected outputs
    while IFS= read -r output; do
        # Get the current resolution of the output
        current_resolution=$(xrandr --query | awk -v output="$output" '/connected primary/ && $1 == output {getline; print $1}')

        # Check if the resolution is retrieved
        if [ -n "$current_resolution" ]; then
            # Compare resolution with max_resolution
            if [ -z "$max_resolution" ] || [[ "$current_resolution" > "$max_resolution" ]]; then
                max_resolution="$current_resolution"
                primary_output="$output"
            fi
        fi
    done < <(xrandr --query | awk '/ connected/ {print $1}')

    # Check if output name is retrieved
    if [ -z "$primary_output" ]; then
        echo "Error: Failed to retrieve output name."
        exit 1
    fi

    # Change the desktop resolution using xrandr
    xrandr --output "$primary_output" --mode "$resolution"

    echo "Desktop resolution restored to $resolution on output $primary_output."
else
    echo "No stored resolution found."
fi

