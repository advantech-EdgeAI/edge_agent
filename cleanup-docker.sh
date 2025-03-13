#!/bin/bash

#remove docker
#I went ahead and uninstalled the new docker footprint.

sudo apt-get remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#ensure that the critical libraries are removed
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

#once ensured all is removed (you don't need to remove the /etc/docker/daemon.json file, that is fine)
#Please install docker the old way
