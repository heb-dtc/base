TIME=$(date | cut -d " " -f 4)
BAT=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -i "percentage" | cut -d " " -f 15)

MSG=$(echo "$TIME$'\n$BAT")

notify-send 'Time and Battery' "$MSG" --icon=dialog-information
