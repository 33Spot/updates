#!/bin/bash
MASK=`xset q | grep LED | cut -d' ' -f 21 | cut -b 8`
if [ $(($MASK & 4)) = 4 ]; then
	xset -led 3
else
	xset led 3
fi
