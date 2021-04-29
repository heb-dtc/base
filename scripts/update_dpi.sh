#!/bin/bash
# change the DPI settings in Xresources

if [ "$AUTORANDR_CURRENT_PROFILE" = "dock" ]
then
  sed -i -e '$s/120/96/' /home/flow/base/dotFiles/i3/Xresources
  notify-send -i display "Display profile" "$AUTORANDR_CURRENT_PROFILE - 96DPI"
elif [ "$AUTORANDR_CURRENT_PROFILE" = "laptop" ]
then
  sed -i -e '$s/96/120/' /home/flow/base/dotFiles/i3/Xresources
  notify-send -i display "Display profile" "$AUTORANDR_CURRENT_PROFILE - 120DPI"
else
  notify-send -i display "Display profile" "$AUTORANDR_CURRENT_PROFILE unknown"
fi

# reload Xresource
xrdb -merge ~/.Xresources
