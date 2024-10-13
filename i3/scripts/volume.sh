#!/bin/bash

get_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po "[0-9]+(?=%)" | head -1
}

is_muted() {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"
}

volume=$(get_volume)

# Generate progress bar
bar=""
for ((i=0; i<volume/5; i++)); do 
    bar+="■"
done
for ((i=volume/5; i<20; i++)); do 
    bar+="□"
done

if is_muted; then
    dunstify -r 9999 -h string:x-dunst-stack-tag:volume "Volume (Muted)" "[$bar] ${volume}%"
else
    dunstify -r 9999 -h string:x-dunst-stack-tag:volume "Volume" "[$bar] ${volume}%"
fi
