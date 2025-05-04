#!/usr/bin/env bash

# Function to display Wofi menu and execute selected command
show_menu() {
    local options=(
        "reboot: Arr! Let’s set sail once more!"
        "shutdown: Lower the sails, we're heading to port..."
        "lock: Batten down the hatches! Locking the ship!"
        "logout: Walk the plank, ye scurvy dog!"
        "suspend: Drop anchor and rest the ship..."
        "hibernate: The crew sleeps 'til the morn..."
        "hybrid-sleep: Half asleep, half awake..."
        "suspend-then-hibernate: Rest yer weary bones, then hibernate!"
        "soft-reboot: A quick wind change and we sail again!"
    )

    # Display Wofi menu
    selected=$(printf '%s\n' "${options[@]}" | wofi --dmenu --prompt "What be yer next move, Captain?" | awk -F': ' '{print $1}')

    # Execute selected command
    case $selected in
        "reboot")
            echo "Executing command: systemctl reboot"
            systemctl reboot
            ;;
        "shutdown")
            echo "Executing command: systemctl poweroff"
            systemctl poweroff
            ;;
        "lock")
            echo "Locking ship's cabin..."
            wpctl set-mute @DEFAULT_SINK@ 1 && hyprlock
            ;;
        "logout")
            echo "Logging out... Walk the plank!"
            hyprctl dispatch exit
            ;;
        "suspend")
            echo "Dropping anchor for a quick rest..."
            systemctl suspend
            ;;
        "hibernate")
            echo "Put the crew to sleep... until the morning light!"
            systemctl hibernate
            ;;
        "hybrid-sleep")
            echo "Half-awake, half-asleep..."
            systemctl hybrid-sleep
            ;;
        "suspend-then-hibernate")
            echo "Rest now, then we hibernate for the voyage ahead."
            systemctl suspend-then-hibernate
            ;;
        "soft-reboot")
            echo "Quick wind change... Soft rebooting!"
            systemctl soft-reboot
            ;;
        *)
            echo "No valid option selected, Captain."
            ;;
    esac
}

# Call function to show menu
show_menu
