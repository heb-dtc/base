#!/bin/bash
intern=eDP1
extern=DP1

if [ $# -ne 1 ]; then
    echo "Usage: provide the wanted screen setup (intern|extern|dual)"
    echo "Example: screens intern|extern|dual"
    exit 1
fi

mode=$1

if [ "$mode" == "extern" ]; then
    if xrandr | grep "$extern disconnected"; then
        echo "external screen not detected. Is it plugged?"
        exit 1
    fi
    xrandr --output "$intern" --off --output "$extern" --auto
elif [ "$mode" == "intern" ]; then
    xrandr --output "$extern" --off --output "$intern" --auto
elif [ "$mode" == "dual" ]; then
    xrandr --output "$extern" --above "$intern" --auto
fi

