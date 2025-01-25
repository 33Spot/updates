#!/bin/bash

function zenityNoWarn() {
    zenity "$@" 2> >(grep -v 'GtkDialog' >&2)
}

FILE=`zenityNoWarn --file-selection --title="Select a File"`
#FILE=`zenityNoWarn --file-selection --title="Select a File"`
#FILE=zenityNoWarn --file-selection --title="Select a File"

#case $? in
#         0)
#                #echo "\"$FILE\" selected.";;
#                pdfbook2 -s $FILE
#         1)
#                echo "No file selected.";;
#        -1)
#                echo "An unexpected error has occurred.";;
#esac

#pdfbook2 -s "/home/spot/.wine/drive_c/Day of Defeat 1.3 Non-Steam v6.6 final waypoints list.pdf"
pdfbook2 --short-edge --no-crop "$FILE"
#pdftocairo -pdf VR_booklet.pdf VR_booklet_repaired.pdf

#--inner-margin=300

#bash
