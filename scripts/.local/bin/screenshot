#!/usr/bin/env bash

# Load XDG user dirs if available
[[ -f "$HOME/.config/user-dirs.dirs" ]] && source "$HOME/.config/user-dirs.dirs"

# Set output directory to ~/Pictures/Screenshots (fallback if XDG_PICTURES_DIR not set)
OUTPUT_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"

# Create directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Kill any ongoing slurp process
pkill slurp 2>/dev/null

# Capture screenshot
hyprshot -m "${1:-region}" --raw |
  satty --filename - \
        --output-filename "$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
        --early-exit \
        --actions-on-enter save-to-clipboard \
        --save-after-copy \
        --copy-command 'wl-copy'
