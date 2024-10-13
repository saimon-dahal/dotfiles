#!/bin/bash

# Function to get current brightness percentage
get_brightness_percent() {
    current=$(brightnessctl g)
    max=$(brightnessctl m)
    echo $((current * 100 / max))
}

# Handle brightness change
case "$1" in
    "up")
        brightnessctl set 5%+ -n
        ;;
    "down")
        brightnessctl set 5%- -n
        ;;
    *)
        echo "Usage: $0 up|down"
        exit 1
        ;;
esac

# Get current brightness and send notification
current_brightness=$(get_brightness_percent)

# Generate progress bar
bar_length=20
filled_length=$((current_brightness * bar_length / 100))
empty_length=$((bar_length - filled_length))

bar="["
for ((i=0; i<filled_length; i++)); do
    bar+="■"
done
for ((i=0; i<empty_length; i++)); do
    bar+="□"
done
bar+="]"

dunstify -r 9999 -h int:value:"$current_brightness" \
    -h string:x-dunst-stack-tag:brightness \
    "Brightness" \
    "$bar ${current_brightness}%"
