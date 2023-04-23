
folder_backupu=~/Pulpit/uzytki/update\ przegladarek/BACKUP_FF_PM_
rm -r "$folder_backupu"$(date +%Y%m%d)

mkdir "$folder_backupu"$(date +%Y%m%d)

tar cfv "$folder_backupu"$(date +%Y%m%d)/FreeTube_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/.config/FreeTube ./
#tar cfv "$folder_backupu"$(date +%Y%m%d)/KeePassXC_DB_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/*.kdbx ./
cp ~/Hasła.kdbx "$folder_backupu"$(date +%Y%m%d)/Hasla_$(date +%Y%m%d).kdbx
cp ~/Pulpit/Hasła.kdbx "$folder_backupu"$(date +%Y%m%d)/Hasła_$(date +%Y%m%d).kdbx

tar cfv "$folder_backupu"$(date +%Y%m%d)/mozilla_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/".mozilla" ./
tar cfv "$folder_backupu"$(date +%Y%m%d)/moonchild_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/".moonchild productions" ./

tar cfv "$folder_backupu"$(date +%Y%m%d)/waterfox_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/".waterfox" ./


rm -r ~/\.config/google-chrome/Default/File\ System
mkdir ~/\.config/google-chrome/Default/File\ System


tar cfv "$folder_backupu"$(date +%Y%m%d)/chrome_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/".config"/google-chrome/Default ./

tar cfv "$folder_backupu"$(date +%Y%m%d)/cinnamon_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/".cinnamon" ./



mkdir ~/.config/jitsi-backup
mv ~/.config/jitsi-nativefier-* ~/.config/jitsi-backup

find ~/.config/jitsi-backup/jitsi-nativefier-* -maxdepth 0 -type d > ~/.config/jitsi-backup/p.txt

   while read -r line;
   do
   for f in "$line"/Cache/*
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
   sleep 1 && echo rm -f -v ./$line/Cache/*;
done < ~/.config/jitsi-backup/p.txt

#pause

rm -f ~/.config/jitsi-backup/p.txt




tar cfv "$folder_backupu"$(date +%Y%m%d)/jitsi-backup_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/".config"/jitsi-backup

mv ~/.config/jitsi-backup/jitsi-nativefier-* ~/.config/
rmdir ~/.config/jitsi-backup








find ~/.config/Ferdium/Partitions -maxdepth 1 -type d | sed -e 's/\.\///g' -e '/\^./d' -e '/\/$/d' > ~/.config/Ferdium/Partitions/p.txt
echo ~/.config/Ferdium >> ~/.config/Ferdium/Partitions/p.txt
echo '' > ~/.config/Ferdium/Partitions/q.txt


while read -r line;
do
   for f in "$line"
   do
      [ -f $line\/Network\ Persistent\ State ] && grep "matrix" $line\/Network\ Persistent\ State -o && echo $line  >> ~/.config/Ferdium/Partitions/q.txt
      [ -f $line\/Network\ Persistent\ State ] && grep -r "accounts.google.pl" $line\/Network\ Persistent\ State -o && echo $line  >> ~/.config/Ferdium/Partitions/q.txt
      [ -f $line\/Network\ Persistent\ State ] && grep -r "web.skype.com" $line\/Network\ Persistent\ State -o && echo $line  >> ~/.config/Ferdium/Partitions/q.txt
      [ -f $line\/Network\ Persistent\ State ] && grep -r "mastodon.xyz" $line\/Network\ Persistent\ State -o && echo $line  >> ~/.config/Ferdium/Partitions/q.txt
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

#ten odblokowac

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
   sleep 1 && echo rm -f -v ./$line/Cache/*;
done < ~/.config/Ferdium/Partitions/p.txt





rm -f ~/.config/Ferdium/Partitions/o.txt ~/.config/Ferdium/Partitions/p.txt ~/.config/Ferdium/Partitions/q.txt ~/.config/Ferdium/Partitions/s.txt


tar cfv "$folder_backupu"$(date +%Y%m%d)/ferdium_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/".config"/Ferdium
tar cfv "$folder_backupu"$(date +%Y%m%d)/beaker_browser_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/".config"/"Beaker Browser" ./
tar cfv "$folder_backupu"$(date +%Y%m%d)/viper_browser_$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/".config"/"Vaccarelli" ./

#tar cfv "$folder_backupu"$(date +%Y%m%d)/firefoxESR$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/Pulpit/uzytki/firefoxESR ./
#tar cfv "$folder_backupu"$(date +%Y%m%d)/palemoon$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/Pulpit/uzytki/palemoon ./
#tar cfv "$folder_backupu"$(date +%Y%m%d)/waterfox$(date +%Y%m%d-%H_%M_%S).tar.gz -C ~/Pulpit/uzytki/waterfox ./

#folder_backupu=~/Pulpit/uzytki/update\ przegladarek/BACKUP_FF_PM_
sh -c "echo 'folder_backupu=~/Pulpit/uzytki/update\ przegladarek/BACKUP_FF_PM_' > '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'unzip_matching_files () {' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo '  if [ \$# -eq 1 ] && [ ! -e \"$1\" ]; then return; fi' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo '  xz -d -f -v \"\$@\"' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo '}' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
#sh -c "echo 'unzip_matching_files \"\$folder_backupu\$(date +%Y%m%d)\"*.tar.gz.xz' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'unzip_matching_files *.tar.gz.xz' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'dir0=FreeTube (in .config)' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'dir0db=KeePassXC_DB (in home)' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'dir1=firefoxESR' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'dir2=palemoon' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'dir3=.mozilla' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
#sh -c "echo 'dir4='\''.moonchild productions'\''' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'dir4=''.moonchild\\ productions''' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'dir5=''.config/google-chrome''' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'dir6=''.cinnamon''' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"

sh -c "echo 'dir7=''.config/Beaker Browser''' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'dir8=''.config/Vaccarelli''' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
#sh -c "echo 'dir5=basilisk' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
#sh -c "echo 'dir6=waterfox' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
#sh -c "echo '#\$ declare \"\$dir4=.moonchild productions\"' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'mkdir \$dir0' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'tar xfv FreeTube*.tar.gz -C \$dir0' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'mkdir \$dir0db' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'tar xfv KeePassXC_DB*.tar.gz -C \$dir0db' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'mkdir \$dir1' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'tar xfv firefoxESR*.tar.gz -C \$dir1' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'mkdir \$dir2' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'tar xfv palemoon*.tar.gz -C \$dir2' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'mkdir \$dir3' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'tar xfv mozilla*.tar.gz -C \$dir3' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'mkdir \$dir4' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'tar xfv moonchild*.tar.gz -C \$dir4' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'mkdir \$dir5' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'tar xfv chrome*.tar.gz -C \$dir5' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'mkdir \$dir6' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'tar xfv cinnamon*.tar.gz -C \$dir6' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"

sh -c "echo 'mkdir \$dir7' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'tar xfv beaker_browser*.tar.gz -C \$dir7' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"

sh -c "echo 'mkdir \$dir8' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
sh -c "echo 'tar xfv viper_browser*.tar.gz -C \$dir8' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"



#sh -c "echo 'mkdir -p \"\$dir4\"' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
#sh -c "echo 'tar xfv moonchild*.tar.gz -C \"\$dir4\"' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
#sh -c "echo 'mkdir \$dir5' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
#sh -c "echo 'tar xfv basilisk*.tar.gz -C \$dir5' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
#sh -c "echo 'mkdir \$dir6' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"
#sh -c "echo 'tar xfv waterfox*.tar.gz -C \$dir6' >> '$folder_backupu$(date +%Y%m%d)/restore.sh'"



chmod +x "$folder_backupu"$(date +%Y%m%d)/restore.sh
clear

for nc_gz in "$folder_backupu"$(date +%Y%m%d)/*.tar.gz; do
  if [ ! -e "$nc_gz" ]; then continue; fi
  xz -z -e -v -7  "$nc_gz"
done

#bash




