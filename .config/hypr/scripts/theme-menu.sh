#!/bin/bash
THEMES_DIR="$HOME/dotfiles/themes"
CURRENT_LINK="$HOME/.config/themes/current"
WALLPAPER_STATE="$HOME/.cache/current-wallpaper"

# Function to set a random wallpaper from theme
set_random_wallpaper() {
    local theme_path="$1"
    local bg_dir="$theme_path/background"
    
    if [ -d "$bg_dir" ]; then
        # Get all image files
        local images=($(find "$bg_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort))
        
        if [ ${#images[@]} -gt 0 ]; then
            # Pick a random image
            local random_index=$((RANDOM % ${#images[@]}))
            local bg_file="${images[$random_index]}"
            
            # Save current wallpaper path for cycling
            echo "$bg_file" > "$WALLPAPER_STATE"
            
            # Create/update hyprpaper config
            cat > ~/.config/hypr/hyprpaper.conf << EOF
preload = $bg_file
wallpaper = ,$bg_file
splash = false
EOF
            
            # Restart hyprpaper
            killall hyprpaper 2>/dev/null
            hyprpaper &
        fi
    fi
}

# Get list of available themes
themes=$(ls -1 "$THEMES_DIR")

# Show rofi menu and get selection
selected=$(echo "$themes" | rofi -dmenu -p "Select Theme")

# Exit if nothing selected
if [ -z "$selected" ]; then
    exit 0
fi

# Remove old symlink if it exists
rm -f "$CURRENT_LINK"

# Create new symlink
ln -s "$THEMES_DIR/$selected" "$CURRENT_LINK"

# Apply Hyprland theme
if [ -f "$CURRENT_LINK/hyprland.conf" ]; then
    hyprctl reload
fi

# Apply Kitty theme
if [ -f "$CURRENT_LINK/kitty.conf" ]; then
    killall -SIGUSR1 kitty
fi

# Apply Starship theme
if [ -f "$CURRENT_LINK/starship.toml" ]; then
    rm -f ~/.config/starship.toml
    ln -snf "$CURRENT_LINK/starship.toml" ~/.config/starship.toml
fi

if [ -f "$CURRENT_LINK/eza.yml" ]; then
    mkdir -p ~/.config/eza
    ln -snf "$CURRENT_LINK/eza.yml" ~/.config/eza/theme.yml
fi

# Apply Btop theme
if [ -f "$CURRENT_LINK/btop.theme" ]; then
    mkdir -p ~/.config/btop/themes
    ln -snf "$CURRENT_LINK/btop.theme" ~/.config/btop/themes/current.theme
    pkill -SIGUSR2 btop
fi

# Apply tmux theme
if [ -f "$CURRENT_LINK/tmux.conf" ]; then
    tmux source-file ~/.config/tmux/tmux.conf 2>/dev/null
    tmux refresh-client 2>/dev/null
fi

# Apply Yazi theme
if [ -d "$CURRENT_LINK/current.yazi" ]; then
    rm -rf ~/.config/yazi/flavors/current.yazi
    
    mkdir -p ~/.config/yazi/flavors
    cp -r "$CURRENT_LINK/current.yazi" ~/.config/yazi/flavors/current.yazi

fi

# Set random wallpaper
set_random_wallpaper "$CURRENT_LINK"

# Restart waybar and swaync
killall waybar
waybar &

killall swaync 
swaync &

notify-send "Theme Changed" "Applied $selected theme"
