#!/bin/bash

# Configuration
THEMES_DIR="$HOME/dotfiles/themes"
CURRENT_LINK="$HOME/.config/themes/current"
WALLPAPER_STATE="$HOME/.cache/current-wallpaper"

# Source modules
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULE_DIR="$SCRIPT_DIR/theme-modules"

source "$MODULE_DIR/wallpaper.sh"
source "$MODULE_DIR/yazi.sh"
source "$MODULE_DIR/apps.sh"
source "$MODULE_DIR/ui.sh"

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

# Apply all themes
apply_all_themes "$CURRENT_LINK"

# Restart yazi
yazi_restart

# Set default wallpaper
set_default_wallpaper "$CURRENT_LINK"

# Restart UI components
restart_ui

# Notify user
notify-send "Theme Changed" "Applied $selected theme"
