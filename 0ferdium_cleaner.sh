#!/bin/bash
#pkill -9 ferdium

#find ~/.config/Ferdium/Partitions -maxdepth 1 -type d | sed -e 's/\.\///g' -e '/\^./d' -e '/\/$/d' > ~/.config/Ferdium/Partitions/p.txt
#echo ~/.config/Ferdium >> ~/.config/Ferdium/Partitions/p.txt


#bash




#grep -r "media.discordapp.net" -o | grep -v 'binar' | sed 's:/.*::'
#pushd ~/.config/Ferdium/Partitions && grep -r "media.discordapp.net" -o | grep -v 'binar' | sed 's:/.*::' && popd

#pushd ~/.config/Ferdium/Partitions && grep -r "media.discordapp.net" -o | grep -v 'binar' | sed 's:/.*::' > o.txt && popd


#for FILE in *; do echo -e "$FILE\nLoops Rule\!" > $FILE; done


#matrix-client.matrix.org


#echo '' > p2.txt
#while read -r line;
#do
#echo \/home\/$USER\/\.config\/Ferdium\/Partitions\/$line >> ~/.config/Ferdium/Partitions/p2.txt
#done < ~/.config/Ferdium/Partitions/o.txt

#while read -r line;
#do
#	for f in "$line"/Cache/Cache_Data/*
#	do
#   	# if file, delete it
#   	echo removing in "$line"/Cache/Cache_Data/
#   	##echo $f
#   	[ -f "$f" ] && rm "$f"
#	done
#	for f in "$line"/Code\ Cache/js/*
#	do
#   	# if file, delete it
#   	echo removing in "$line"/Code\ Cache/js/
#   	##echo $f
#   	[ -f "$f" ] && rm "$f"
#	done
#   sleep 1 && echo rm -f -v ./$line/Cache/*;
#done < ~/.config/Ferdium/Partitions/p2.txt

find ~/.config/Ferdium/Partitions -maxdepth 1 -type d | sed -e 's/\.\///g' -e '/\^./d' -e '/\/$/d' > ~/.config/Ferdium/Partitions/p.txt
echo ~/.config/Ferdium >> ~/.config/Ferdium/Partitions/p.txt
echo ~/.config/FreeTube >> ~/.config/Ferdium/Partitions/p.txt
echo '' > ~/.config/Ferdium/Partitions/q.txt


while read -r line;
do
   for f in "$line"
   do
      [ -f $line\/Network\ Persistent\ State ] && grep "matrix" $line\/Network\ Persistent\ State -o && echo $line  >> ~/.config/Ferdium/Partitions/q.txt
      [ -f $line\/Network\ Persistent\ State ] && grep "accounts.google.pl" $line\/Network\ Persistent\ State -o && echo $line  >> ~/.config/Ferdium/Partitions/q.txt
      [ -f $line\/Network\ Persistent\ State ] && grep "web.skype.com" $line\/Network\ Persistent\ State -o && echo $line  >> ~/.config/Ferdium/Partitions/q.txt
      [ -f $line\/Network\ Persistent\ State ] && grep "mastodon.xyz" $line\/Network\ Persistent\ State -o && echo $line  >> ~/.config/Ferdium/Partitions/q.txt
      [ -f $line\/Network\ Persistent\ State ] && grep "tvn24.pl" $line\/Network\ Persistent\ State -o && echo $line  >> ~/.config/Ferdium/Partitions/q.txt
      # >> ~/.config/Ferdium/Partitions/q.txt
      #&& echo sed -i 's/\/home\/$USER\/.config\/Ferdium\/Partitions//g'
      #&& pushd $line && grep "#matrix-client.matrix.org" $line\/Network\ Persistent\ State -o && popd
      #&& popd
   done
   #sed -i 's:.*/::' ~/.config/Ferdium/Partitions/q.txt


#   while read -r check;
#   do
      #echo $check
#      mv $check $check'_backup'
      #sed 's/$check//g' < ~/.config/Ferdium/Partitions/p.txt > ~/.config/Ferdium/Partitions/s.txt

#   for f in "$line"/Cache/Cache_Data/*
#   do
#      # if file, delete it
#      echo removing in "$line"
#      [ -f "$f" ] && rm "$f"
#   done
#   for f in "$line"/Code\ Cache/js/*
#   do
#      # if file, delete it
#      echo removing in "$line"
#      [ -f "$f" ] && rm "$f"
#   done
#   sleep 1 && echo rm -f -v ./$line/Cache/*;
#done < ~/.config/Ferdium/Partitions/q.txt
done < ~/.config/Ferdium/Partitions/p.txt


grep -Fvxf q.txt p.txt


while read -r line;
do
   for f in "$line"/Cache/Cache_Data/*
   do
      # if file, delete it
      echo removing in "$line"
      [ -f "$f" ] && rm "$f"
   done
   for f in "$line"/Code\ Cache/js/*
   do
      # if file, delete it
      echo removing in "$line"
      [ -f "$f" ] && rm "$f"
   done
   for f in "$line"/Service\ Worker/CacheStorage/*
   do
      # if file, delete it
      echo removing in "$line"
      [ -f "$f" ] && rm "$f"
   done
   for f in "$line"/dashFiles/*
   do
      # if file, delete it
      echo removing in "$line"
      [ -f "$f" ] && rm "$f"
   done
   #sleep 1 && echo rm -f -v ./$line/Cache/*;
done < ~/.config/Ferdium/Partitions/p.txt


rm -f ~/.config/Ferdium/Partitions/o.txt ~/.config/Ferdium/Partitions/p.txt ~/.config/Ferdium/Partitions/q.txt ~/.config/Ferdium/Partitions/s.txt





#echo done
#read r

#rm -f ~/.config/Ferdium/Partitions/p.txt

#rm -f ~/.config/Ferdium/Partitions/o.txt ~/.config/Ferdium/Partitions/p.txt ~/.config/Ferdium/Partitions/p2.txt
#bash


