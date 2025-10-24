#!/bin/bash
CURRENT_LINK="$HOME/.config/themes/current"
WALLPAPER_STATE="$HOME/.cache/current-wallpaper"

# Get background directory from current theme
bg_dir="$CURRENT_LINK/background"

if [ ! -d "$bg_dir" ]; then
    notify-send "Wallpaper Cycler" "No background folder found in current theme"
    exit 1
fi

# Get all image files sorted
images=($(find "$bg_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort))

if [ ${#images[@]} -eq 0 ]; then
    notify-send "Wallpaper Cycler" "No images found in background folder"
    exit 1
fi

# If only one image, keep it
if [ ${#images[@]} -eq 1 ]; then
    notify-send "Wallpaper Cycler" "Only one wallpaper available"
    exit 0
fi

# Get current wallpaper
current_wallpaper=$(cat "$WALLPAPER_STATE" 2>/dev/null)

# Find current index
current_index=-1
for i in "${!images[@]}"; do
    if [ "${images[$i]}" = "$current_wallpaper" ]; then
        current_index=$i
        break
    fi
done

# Get next index (cycle to 0 if at end)
next_index=$(( (current_index + 1) % ${#images[@]} ))
next_wallpaper="${images[$next_index]}"

# Save new wallpaper
echo "$next_wallpaper" > "$WALLPAPER_STATE"

# Update hyprpaper config
cat > ~/.config/hypr/hyprpaper.conf << EOF
preload = $next_wallpaper
wallpaper = ,$next_wallpaper
splash = false
EOF

# Restart hyprpaper
killall hyprpaper 2>/dev/null
hyprpaper &

# Get just the filename for notification
filename=$(basename "$next_wallpaper")
notify-send "Wallpaper Changed" "$filename"
