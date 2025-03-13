#!/bin/bash

#Disabling the Desktop GUI
#If you're running low on memory, you may want to try disabling the Ubuntu desktop GUI. This will free up extra memory that the window manager and desktop uses (around ~800MB for Unity/GNOME or ~250MB for LXDE)

#You can disable the desktop temporarily, run commands in the console, and then re-start the desktop when desired:

$ sudo init 3     # stop the desktop
# log your user back into the console (Ctrl+Alt+F1, F2, ect)
$ sudo init 5     # restart the desktop

#If you wish to make this persistent across reboots, you can use the follow commands to change the boot-up behavior:
$ sudo systemctl set-default multi-user.target     # disable desktop on boot
$ sudo systemctl set-default graphical.target      # enable desktop on boot
