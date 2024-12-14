#!/bin/bash

# Function to check if a fullscreen window is active
is_fullscreen() {
    # Use xprop to check if any window is in fullscreen state
    xprop -root _NET_ACTIVE_WINDOW | grep -q '\(0x\)' && \
    xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d' ' -f5) | grep -qE "_NET_WM_STATE_FULLSCREEN"
}

# Function to check if a specific application is running in fullscreen
is_media_app() {
    # Check for common media and meeting applications
    xdotool search --desktop 0 --class '.*' getwindowname | \
    grep -qiE '(youtube|chrome|firefox|chromium|zoom|teams|meet\.google\.com|vlc|mpv|spotify)'
}

# If no fullscreen app is running, lock the screen
if ! is_fullscreen && ! is_media_app; then
    betterlockscreen -l dim
else
    echo "Fullscreen or media app is active. Skipping lock."
fi
