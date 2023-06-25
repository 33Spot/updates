rsync -v -r --include='**/' --include='*.state*' --include='*.srm' --exclude='*' --prune-empty-dirs pi@192.168.2.115:~/RetroPie/roms/ ./PIBOY_savy_backup_$(date +%Y%m%d)
tar cfv "PIBOY_savy_backup_$(date +%Y%m%d).tar.gz" -C ./PIBOY_savy_backup_$(date +%Y%m%d)/ ./ 2>/dev/null
rmdir -r ./PIBOY_savy_backup_$(date +%Y%m%d)
clear
xz -z -e -v -7 PIBOY_savy_backup_*.tar.gz
