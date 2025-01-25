#!/bin/bash

function zenityNoWarn() {
    zenity "$@" 2> >(grep -v 'GtkDialog' >&2)
}

FILE=`zenityNoWarn --file-selection --title="Select a File"`
DIRNAME=$(dirname "$FILE")
BASENAME=$(basename "$FILE" .pdf)
BOOKLET_FILE="$DIRNAME/${BASENAME}-book.pdf"
pdftocairo -pdf "$FILE" "$DIRNAME/${BASENAME}_fixed.pdf"
#bash
