sudo apt-get install earlyoom
#sudo apt-get install oomd

#sudo systemctl enable --now oomd.service
#sudo systemctl enable --now oomd.service
sudo systemctl unmask earlyoom.service
sudo systemctl enable --now earlyoom
sudo systemctl start earlyoom
#systemctl status earlyoom


#sudo systemctl start oomd
#systemctl status oomd





sudo sh -c "echo '1' > /proc/sys/vm/oom_kill_allocating_task"
cat /proc/sys/vm/oom_kill_allocating_task
sudo sed "/kernel.sysrq=/c\kernel.sysrq=1" /etc/sysctl.conf -i
sudo sysctl -p


