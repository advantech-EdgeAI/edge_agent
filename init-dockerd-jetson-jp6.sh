#!/bin/bash
#
## ref. to https://docs.nvidia.com/jetson/jetpack/install-setup/index.html
# 
# Exit script if a command retured with a non-zero status
set -e

#turn on nvidia apt source for further update
sudo sed -i 's/^# deb/deb/g' /etc/apt/sources.list.d/nvidia-l4t-apt-source.list
sudo apt update

## If disk space is limited, use these commands:
apt depends nvidia-jetpack | awk '{print $2}' | xargs -I {} sudo apt install -y {}

sudo apt install -y nvidia-container curl
#curl https://get.docker.com | sh && sudo systemctl --now enable docker
curl https://get.docker.com | sudo sh


## ref. to https://github.com/jetsonhacks/install-docker
# An issue with the current Docker 28.0.0 requires a different set of kernel modules to be enabled.
# The JetPack 6.2 release of Jetson doesn't support these. So we downgrade
sudo apt-get install -y docker-ce=5:27.5.1-1~ubuntu.22.04~jammy --allow-downgrades
sudo apt-get install -y docker-ce-cli=5:27.5.1-1~ubuntu.22.04~jammy --allow-downgrades
sudo apt-get install -y docker-compose-plugin=2.32.4-1~ubuntu.22.04~jammy --allow-downgrades
sudo apt-get install -y docker-buildx-plugin=0.20.0-1~ubuntu.22.04~jammy --allow-downgrades
sudo apt-get install -y docker-ce-rootless-extras=5:27.5.1-1~ubuntu.22.04~jammy --allow-downgrades

# The we mark them held so they do not get upgraded with apt upgrade
sudo apt-mark hold docker-ce=5:27.5.1-1~ubuntu.22.04~jammy
sudo apt-mark hold docker-ce-cli=5:27.5.1-1~ubuntu.22.04~jammy
sudo apt-mark hold docker-compose-plugin=2.32.4-1~ubuntu.22.04~jammy
sudo apt-mark hold docker-buildx-plugin=0.20.0-1~ubuntu.22.04~jammy
sudo apt-mark hold docker-ce-rootless-extras=5:27.5.1-1~ubuntu.22.04~jammy

sudo systemctl --now enable docker
sudo nvidia-ctk runtime configure --runtime=docker

# Checking on the existence of docker group
if getent group docker >/dev/null 2>&1; then
    echo "Group 'docker' exists."
else
    sudo groupadd docker
fi
# Adding current user to docker group.
sudo usermod -aG docker $USER
# check if any error to login docker group
newgrp docker

# give it a fresh restart
sudo systemctl daemon-reload && sudo systemctl restart docker

# turn off nvidia apt source to avoid unexpected update
sudo sed -i 's/^deb/# deb/g' /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

echo "Docker installation done."
docker --version 

set +e

## R36.3/JP 6.0
## Add the R36.4/JP 6.1 repo:
#echo "deb https://repo.download.nvidia.com/jetson/common r36.4 main" | sudo tee -a /etc/apt/sources.list.d/nvidia-l4t-apt-source.list
#echo "deb https://repo.download.nvidia.com/jetson/t234 r36.4 main" | sudo tee -a /etc/apt/sources.list.d/nvidia-l4t-apt-source.list
#