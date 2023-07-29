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
dir=compress
mkdir $dir
for i in *.jpg; do jpegoptim --max=60 -d ./$dir -p "$i"; done
for i in *.JPG; do jpegoptim --max=60 -d ./$dir -p "$i"; done
echo done!
bash


