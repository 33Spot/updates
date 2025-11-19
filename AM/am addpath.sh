#!/usr/bin/env bash

# Define the snippet
snippet='if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi'

# File to update
bashrc_file="$HOME/.bashrc"

# Check if the snippet already exists
if grep -Fq 'PATH="$HOME/.local/bin:$PATH"' "$bashrc_file"; then
    echo "Snippet already exists in $bashrc_file"
else
    echo "Adding snippet to $bashrc_file"
    echo -e "\n$snippet" >> "$bashrc_file"
    echo "Snippet added."
fi

