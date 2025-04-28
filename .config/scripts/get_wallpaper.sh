#!/bin/bash

WALL_DIR="$HOME/Pictures/wallpapers"
PROFILE_DIR="$HOME/Pictures/profile_pictures"

WALL_FILE="red_wallpaper.jpg"
PROFILE_FILE="hypr.jpg"

WALL_PATH="$WALL_DIR/$WALL_FILE"
PROFILE_PATH="$PROFILE_DIR/$PROFILE_FILE"

WALL_URL="https://w.wallhaven.cc/full/0w/wallhaven-0wrprp.jpg"
PROFILE_URL="https://w.wallhaven.cc/full/0w/wallhaven-0w9lmr.jpg"  # Corrected to direct image

mkdir -p "$WALL_DIR"
mkdir -p "$PROFILE_DIR"

if [ ! -f "$WALL_PATH" ]; then
    echo "Downloading wallpaper..."
    curl -L -o "$WALL_PATH" "$WALL_URL"
else
    echo "Wallpaper already exists at $WALL_PATH"
fi

if [ ! -f "$PROFILE_PATH" ]; then
    echo "Downloading profile picture..."
    curl -L -o "$PROFILE_PATH" "$PROFILE_URL"
else
    echo "Profile picture already exists at $PROFILE_PATH"
fi
