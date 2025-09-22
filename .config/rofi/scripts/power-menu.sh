#!/usr/bin/env bash

# Function to display Rofi menu and execute selected command
show_menu() {
    local options=(
        "shutdown: Lights out."
        "reboot: New case."
        "lock: File sealed."
        "logout: Out the door."
        "suspend: Taking five."
        "hibernate: Long nap."
        "hybrid-sleep: Half out."
        "suspend-then-hibernate: Five, then gone."
        "soft-reboot: Quick reset."
    )

    # Display Rofi menu and extract command key
    selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -p "Move?" | awk -F': ' '{print $1}')

    # Execute selected command
    case $selected in
        "reboot")
            echo "Rebooting — starting a new case..."
            systemctl reboot
            ;;
        "shutdown")
            echo "Lights out — shutting it down."
            systemctl poweroff
            ;;
        "lock")
            echo "Sealing the file — locking screen."
            wpctl set-mute @DEFAULT_SINK@ 2 && hyprlock
            ;;
        "logout")
            echo "Case closed — logging out."
            hyprctl dispatch exit
            ;;
        "suspend")
            echo "Taking five — suspending..."
            systemctl suspend
            ;;
        "hibernate")
            echo "Going dark — hibernating..."
            systemctl hibernate
            ;;
        "hybrid-sleep")
            echo "Half out — hybrid sleep mode."
            systemctl hybrid-sleep
            ;;
        "suspend-then-hibernate")
            echo "Five, then gone — suspending then hibernating."
            systemctl suspend-then-hibernate
            ;;
        "soft-reboot")
            echo "Quick reset — soft reboot."
            systemctl soft-reboot
            ;;
        *)
            echo "No call made. Case stays open."
            ;;
    esac
}

# Call function to show menu
show_menu
