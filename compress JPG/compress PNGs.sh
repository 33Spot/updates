#!/bin/sh

#set +o noglob 
#set -o noglob
# compress all \*.jpg files in the current directory 
# and place them in ./compressed directory
# with the same modification date as original files.
#sudo apt-get install jpegoptim 
#cd $(pwd)
#for i in \*.jpg; do jpegoptim -d ./compressed -p "$i"; done
#for i in \*.jpg; do jpegoptim --dest=./compressed -p "$i"; done
#for i in \*.jpg; do jpegoptim \*.jpg -dcompress -p -v "$i"; done

#jpegoptim \*.jpg -dcompress -p -v
#jpegoptim \*.jpg -d compress/

#mkdir $dir && find $(pwd) -type f -iname *.jpg -exec jpegoptim --max=60 -d $(pwd)/$dir/ --all-progressive -p {} \;
#mkdir $dir && find $(pwd) -type f -iname *.jpg -exec jpegoptim --max=60 -d ./$dir/ --all-progressive -p {} \;
#!/bin/sh

# compress all *.jpg files in the current directory 
# and place them in ./compressed directory
# with the same modification date as original files.
dir=compressPNG
#optipng -o2 -strip all <image.png>
mkdir $dir
for i in *.png; do cp "$i" $pwd ./$dir && optipng -o7 -strip all ./$dir/"$i"; done
for i in *.png; do optipng -o5 -quiet -keep -preserve -dir compressPNG -log optipng.log "$i"; done
for i in *.PNG; do cp "$i" $pwd ./$dir && optipng -o7 -strip all ./$dir/"$i"; done
for i in *.PNG; do optipng -o5 -quiet -keep -preserve -dir compressPNG -log optipng.log "$i"; done
#cp IMG_7393.JPG $pwd $folder
echo done!
bash

#optipng -o2 -strip all <image.png>
#optipng -o7 -strip all <image.png>







