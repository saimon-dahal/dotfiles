
#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers/monochrome/"
DELAY=300

while true; do
    for img in "$WALLPAPER_DIR"/*.{jpg,png,jpeg}; do
        [ -e "$img" ] || continue
        swww img "$img" --transition-type any --transition-duration 1
        sleep "$DELAY"
    done
done
