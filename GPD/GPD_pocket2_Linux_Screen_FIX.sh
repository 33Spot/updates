
# ROTATE DISPLAY

xrandr -o right

# SET DISPLAY TO A SMALLER RESOLUTION

#xrandr --newmode "600x950_60.00"   46.75 600 640 696 792 950 953 963 986 -hsync +vsync
#xrandr --addmode eDP-1 "600x950_60.00"
#xrandr --output eDP-1 --mode 600x950_60.00

# ROTATE TOUCHSCREEN
# Goodix Capacitive Touchscreen id=15

xinput set-prop 15 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1

sudo apt install mint-legacy-themes

# https://www.ndhfilms.com/other/gpdpocket2#rotatedisplayandtouchscreen
