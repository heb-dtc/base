#!/bin/bash
# changeVolume

# if using amixer, params should be 5%+ or 5%-
# if using pactl, params should be +5%+ or -5%

# Arbitrary but unique message id
msgId="991049"

# Change the volume using alsa(might differ if you use pulseaudio)
#amixer -c 0 set Master "$@" > /dev/null

#find the running sink
# TODO there might be more than one sink active. Need to check for that
index=$(pactl list short sinks | grep 'RUNNING' | cut -f1)

#TODO check if index is empty, meaning no sink is active.
#TODO and display a notification

if [ "$@" = "mute" ] 
then
  pactl set-sink-mute $index toggle
  #amixer -D pulse set $index toggle > /dev/null
else
  pactl set-sink-volume $index "$@"
  #amixer -D pulse set $index "$@" unmute > /dev/null
fi

# Query amixer for the current volume and whether or not the speaker is muted
#volume="$(amixer -D pulse get Master | tail -1 | awk '{print $5}' | sed 's/[^0-9]*//g')"
#mute="$(amixer -D pulse get Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"

# Query pactl for current volume and if muted or not
volume="$(pamixer --sink $index --get-volume)"
mute="$(pamixer --sink $index --get-mute)"

if [[ $volume == 0 || "$mute" == "true" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -r "$msgId" "Volume muted" 
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i audio-volume-high -r "$msgId" \
    -h int:value:"$volume" "Volume: ${volume}%"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
