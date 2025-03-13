#!/bin/bash

# Clone Jetson-containers and install:
cd /ssd

JCI=jetson-containers/install.sh
if [ ! -f $JCI ];
then
    git clone https://github.com/dusty-nv/jetson-containers
    bash $JCI
fi

# Clone Edge Agent and pre-configure:
git clone https://github.com/advantech-EdgeAI/edge_agent.git

OWL=/ssd/edge_agent/nanoowl/data/owlv2.engine
if [ ! -f $OWL ];
then
    docker run --name share-volume00-container ispsae/share-volume00
    docker cp share-volume00-container:/data/. /ssd/edge_agent/pre_install/
    mv /ssd/edge_agent/pre_install/owlv2.engine /ssd/edge_agent/nanoowl/data/
fi

# Extract demo videos in /ssd/edge_agent/pre_install
# then move database and data in /ssd/edge_agent/pre_install to Jetson-containers folder
cd /ssd/edge_agent/pre_install
tar xfz demo-videos.tgz --strip-components=1
mv nanodb /ssd/jetson-containers/data/
mv forbidden_zone /ssd/jetson-containers/data/images/
mv demo /ssd/jetson-containers/data/videos/

# Pull the Edge Agent docker images
sudo docker pull ispsae/nano_llm:nano_llm-24.7-r36.2.0_bug_fixed
#sudo docker tag ispsae/nano_llm:nano_llm-24.7-r36.2.0_bug_fixed dustynv/nano_llm: nano_llm-24.7-r36.2.0_bug_fixed
sudo docker images
