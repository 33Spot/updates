#!/bin/bash

# Check if Zenity is installed
if ! command -v zenity &> /dev/null; then
    echo "Zenity is not installed. Please install Zenity to proceed."
    exit 1
fi

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <script_file> <installation_directory>"
    exit 1
fi

# Extract parameters
script_file="$1"
installation_dir="$2"

# Check if the script file exists
if [ ! -f "$script_file" ]; then
    echo "Error: Script file '$script_file' not found."
    exit 1
fi

# Check if the installation directory exists
if [ ! -d "$installation_dir" ]; then
    echo "Error: Installation directory '$installation_dir' not found."
    exit 1
fi

# Function to display an error message and exit
display_error_and_exit() {
    zenity --error --text="$1"
    exit 1
}

# Function to display a confirmation dialog
display_confirmation() {
    zenity --question --text="$1" --title="Confirmation"
}

# Function to display an info dialog
display_info() {
    zenity --info --text="$1" --title="Information"
}

# Function to copy the script to the installation directory
copy_script() {
    cp "$script_file" "$installation_dir" || display_error_and_exit "Failed to copy script to $installation_dir"
    chmod +x "$installation_dir/$(basename "$script_file")" || display_error_and_exit "Failed to set execute permissions for $installation_dir/$(basename "$script_file")"
}

# Main function
main() {
    # Display welcome message
    display_info "Welcome to the installation wizard!"

    # Check if the script is already installed
    if [ -f "$installation_dir/$(basename "$script_file")" ]; then
        if ! display_confirmation "The script is already installed. Do you want to reinstall it?"; then
            display_info "Installation cancelled."
            exit 0
        fi
    fi

    # Copy the script to the installation directory
    copy_script

    # Display installation success message
    display_info "Installation completed successfully!"
}

# Run the main function
main

