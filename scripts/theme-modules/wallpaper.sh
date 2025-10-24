#!/bin/bash


# Function to set default wallpaper from theme
set_default_wallpaper() {
    local theme_path="$1"
    local bg_file="$theme_path/background/default.jpg"
    
    # Check if default wallpaper exists
    if [ ! -f "$bg_file" ]; then
        if [ -f "$theme_path/background/default.png" ]; then
            bg_file="$theme_path/background/default.png"
        elif [ -f "$theme_path/background/default.jpeg" ]; then
            bg_file="$theme_path/background/default.jpeg"
        else
            echo "Warning: No default wallpaper found in $theme_path/background/"
            return 1
        fi
    fi
    
    # Resolve to absolute path
    bg_file=$(realpath "$bg_file")
    
    # Save current wallpaper path
    echo "$bg_file" > "$WALLPAPER_STATE"
    
    # Create/update hyprpaper config
    cat > ~/.config/hypr/hyprpaper.conf << EOF
preload = $bg_file
wallpaper = ,$bg_file
splash = false
EOF
    
    # Update hyprlock background
    
    # Restart hyprpaper
    killall hyprpaper 2>/dev/null
    hyprpaper &
}
