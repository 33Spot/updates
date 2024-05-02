#!/bin/bash

# Check if xbindkeys is installed
if ! command -v xbindkeys &> /dev/null; then
    echo "Error: xbindkeys is not installed. Please install it first."
    exit 1
fi

# Check if the script path is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 /path/to/script"
    exit 1
fi

script_path=$1

# Check if the script file exists
if [ ! -f "$script_path" ]; then
    echo "Error: Script file not found at $script_path"
    exit 1
fi

# Create a default xbindkeys configuration file if it doesn't exist
if [ ! -f ~/.xbindkeysrc ]; then
    xbindkeys --defaults > ~/.xbindkeysrc
fi

# Append the configuration to the xbindkeys configuration file
echo "\"$script_path\"
    Control+Shift+F5" >> ~/.xbindkeysrc

# Restart xbindkeys to apply the changes
killall xbindkeys && xbindkeys

echo "Custom keyboard shortcut configured successfully."

