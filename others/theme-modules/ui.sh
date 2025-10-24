#!/bin/bash

# Restart UI components
restart_ui() {
    # Restart waybar
    killall waybar
    waybar &
    
    # Restart swaync
    killall swaync 
    swaync &
}
