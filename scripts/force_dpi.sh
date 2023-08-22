#!/bin/bash
# change the DPI settings in Xresources

case $1 in 
120)
    sed -i -e 's/.*Xft.dpi.*/Xft.dpi: 120/' /home/flow/.Xresources
    notify-send -i display "Display profile - 120DPI"
    xrdb -merge /home/flow/.Xresources
    ;;
96)
    sed -i -e 's/.*Xft.dpi.*/Xft.dpi: 96/' /home/flow/.Xresources
    notify-send -i display "Display profile - 96DPI"
    xrdb -merge /home/flow/.Xresources
    ;;
*)
    echo "wrong input, valid DPI values are 96 or 120"
    ;;
esac

