#!/bin/bash

#Mounting Swap
#If you're building containers or working with large models, it's advisable to mount SWAP (typically correlated with the amount of memory in the board). Run these commands to disable ZRAM and create a swap file:

sudo systemctl disable nvzramconfig
sudo fallocate -l 16G /mnt/16GB.swap
sudo mkswap /mnt/16GB.swap
sudo swapon /mnt/16GB.swap
#If you have NVME storage available, it's preferred to allocate the swap file on NVME.

#Then add the following line to the end of /etc/fstab to make the change persistent:
#/mnt/16GB.swap  none  swap  sw 0  0
echo "/mnt/16GB.swap  none  swap  sw 0  0" | sudo tee -a /etc/fstab
