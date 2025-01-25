#!/bin/bash

function zenityNoWarn() {
    zenity "$@" 2> >(grep -v 'GtkDialog' >&2)
}

FILE=$(zenityNoWarn --file-selection --title="Select a File")

# Check if a file was selected
if [[ -z "$FILE" ]]; then
    echo "No file selected."
    exit 1
fi

# Run pdfbook2 to create a booklet
pdfbook2 --short-edge --no-crop "$FILE"

# Determine output booklet filename based on input filename
DIRNAME=$(dirname "$FILE")
BASENAME=$(basename "$FILE" .pdf)
BOOKLET_FILE="$DIRNAME/${BASENAME}-book.pdf"

# Check if the booklet file was created
if [[ ! -f "$BOOKLET_FILE" ]]; then
    echo "Error: Booklet file not found."
    exit 1
fi

# Process the booklet file with pdftocairo
pdftocairo -pdf "$BOOKLET_FILE" "$DIRNAME/${BASENAME}_book.pdf"

# Remove the intermediate file
rm -f "$BOOKLET_FILE"

echo "Process completed successfully. Output file: \"$DIRNAME/${BASENAME}_book.pdf\""

