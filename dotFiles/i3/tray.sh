#!/bin/bash

pkill -f pasystray
pkill -f blueman-applet
pkill -f nm-applet
pkill -f qckm

pasystray --notify=all &
blueman-applet &
nm-applet --indicator &
udiskie -t &
qckm &

