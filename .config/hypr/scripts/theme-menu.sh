#!/bin/bash
THEMES_DIR="$HOME/dotfiles/themes"
CURRENT_LINK="$HOME/.config/themes/current"
WALLPAPER_STATE="$HOME/.cache/current-wallpaper"

yazi-restart() {
    if pgrep -x yazi >/dev/null; then
        local pids=($(pgrep -x yazi))
        local restarted=0
        
        for pid in "${pids[@]}"; do
            local current_pid=$pid
            local window_addr=""
            
            # Walk up the process tree to find a window
            while [[ $current_pid -gt 1 && -z "$window_addr" ]]; do
                window_addr=$(hyprctl clients -j | jq -r --arg pid "$current_pid" '.[] | select(.pid == ($pid | tonumber)) | .address' 2>/dev/null)
                
                if [[ -n "$window_addr" ]]; then
                    break
                fi
                
                current_pid=$(ps -o ppid= -p $current_pid 2>/dev/null | tr -d ' ')
                [[ -z "$current_pid" ]] && break
            done
            
            if [[ -n "$window_addr" ]]; then
                # Focus the window first
                hyprctl dispatch focuswindow address:$window_addr
                sleep 0.05
                
                # Kill the yazi process
                kill $pid
                sleep 0.15
                
                # Send command much faster
                if command -v ydotool >/dev/null; then
                    # Ctrl+C (quick clear)
                    ydotool key 29:1 46:1 46:0 29:0
                    sleep 0.05
                    # Type yazi faster with --key-delay
                    ydotool type --key-delay 0 "yazi"
                    sleep 0.05
                    ydotool key 28:1 28:0
                elif command -v wtype >/dev/null; then
                    wtype -M ctrl -P c -m ctrl
                    sleep 0.05
                    wtype -d 0 "yazi"  # -d 0 for instant typing
                    sleep 0.05
                    wtype -k Return
                fi
                
                ((restarted++))
            fi
        done
        
        printf "Restarted yazi in %d window(s)\n" "$restarted" >&2
    fi
}
# Function to set a random wallpaper from theme
set_default_wallpaper() {
    local theme_path="$1"
    local bg_file="$theme_path/background/default.jpg"
    
    # Check if default wallpaper exists
    if [ ! -f "$bg_file" ]; then
        # Try other common extensions if default.jpg doesn't exist
        if [ -f "$theme_path/background/default.png" ]; then
            bg_file="$theme_path/background/default.png"
        elif [ -f "$theme_path/background/default.jpeg" ]; then
            bg_file="$theme_path/background/default.jpeg"
        else
            echo "Warning: No default wallpaper found in $theme_path/background/"
            return 1
        fi
    fi
    
    # Resolve to absolute path (in case it's a symlink)
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
    update_hyprlock_background "$bg_file"
    
    # Restart hyprpaper
    killall hyprpaper 2>/dev/null
    hyprpaper &
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
    # Remove old current flavor
    rm -rf ~/.config/yazi/flavors/current.yazi
    
    mkdir -p ~/.config/yazi/flavors
    ln -snf -r "$CURRENT_LINK/current.yazi" ~/.config/yazi/flavors/current.yazi
fi
yazi-restart
# Set random wallpaper
set_default_wallpaper "$CURRENT_LINK"

# Restart waybar and swaync
killall waybar
waybar &

killall swaync 
swaync &

notify-send "Theme Changed" "Applied $selected theme"
