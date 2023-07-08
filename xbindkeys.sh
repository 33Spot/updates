sudo apt-get install xbindkeys
#xbindkeys --defaults > ~/.xbindkeysrc
#lapanie sskrotow klawiaturowych
#xbindkeys -k
cp ./xbindkeysrc ~/.xbindkeysrc
xbindkeys --file ~/.xbindkeysrc
# gnome-session-properties


#       Available command line options are as follows:
#       -d, --defaults
#              Print a default rc file
#       -f, --file
#              Use an alternative rc file
#       -h, --help
#              Short help on options plus version/author info.
#       -X, --display
#              Set X display to use
#       -v, --verbose
#              More information on xbindkeys when it run
#       -k, --key
#              Identify one key pressed (useful to fill the configuration file)
#       -mk, --multikey
#              Identify multi key pressed (useful to fill the configuration file)
#       -g, --geometry
#              size and position of window with -k|-mk option
#       -n, --nodaemon
#              don't start as daemon
#       If guile support have not been disabled:
#       -dg, --defaults-guile
#              Print a default guile configuration file
#       -fg, --file-guile
#              Use an alternative guile configuration file