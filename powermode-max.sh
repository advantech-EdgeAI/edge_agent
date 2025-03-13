#!/bin/bash

##Set to MAX Power Mode
# check the current power mode
#$ sudo nvpmodel -q

# set it to mode 0 (typically the highest)
sudo nvpmodel -m 0
