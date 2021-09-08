#!/bin/bash -x

sudo echo ###################### stop cloud-init
sudo systemctl stop cloud-init
sudo rm -f /etc/machine-id
sudo touch /etc/machine-id
sudo echo ###################### clean cloud-init cache
sudo cloud-init clean -s -l
sudo rm -rf /var/log/cloud
sudo rm -rf /var/lib/cloud/*
sudo rm -rf /etc/cloud/cloud.cfg.d/curtin-preserve-sources.cfg
sudo rm -rf /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg
sudo rm -rf /etc/cloud/cloud.cfg.d/99-installer.cfg
sudo echo ###################### update CMDLINE_LINUX_DEFAULT
#sudo sed -i 's/seedfrom=.*/seedfrom=\/dev\/sr0\"/g' /etc/default/grub 
sed -i -e 's/autoinstall ds=nocloud;/ quiet net.ifnames=0 biosdevname=0/' /etc/default/grub
sudo update-grub2

