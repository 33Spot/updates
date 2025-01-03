if [ -x /usr/games/cowsay -a -x /usr/games/fortune ]; then
fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)
fi
read r

