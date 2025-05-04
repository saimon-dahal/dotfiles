
#!/usr/bin/env bash

# Function to display Wofi menu and execute selected command
show_menu() {
    local options=(
        "reboot: Shut down and reboot the system"
        "shutdown: Shut down and power-off the system"
        "lock: Lock the screen"
        "logout: Log out current user"
        "suspend: Suspend the system"
        "hibernate: Put the system into hibernation"
        "hybrid-sleep: Put the system into hybrid-sleep state"
        "suspend-then-hibernate: Suspend and then hibernate"
        "soft-reboot: Perform a soft reboot of userspace"
    )

    # Display Wofi menu
    selected=$(printf '%s\n' "${options[@]}" | wofi --dmenu --prompt "Choose an action:" | awk -F': ' '{print $1}')

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
            echo "Locking screen..."
            wpctl set-mute @DEFAULT_SINK@ 1 && hyprlock
            ;;
        "logout")
            echo "Logging out..."
            hyprctl dispatch exit
            ;;
        "suspend")
            echo "Suspending the system..."
            systemctl suspend
            ;;
        "hibernate")
            echo "Putting the system into hibernation..."
            systemctl hibernate
            ;;
        "hybrid-sleep")
            echo "Putting the system into hybrid-sleep state..."
            systemctl hybrid-sleep
            ;;
        "suspend-then-hibernate")
            echo "Suspending then hibernating the system..."
            systemctl suspend-then-hibernate
            ;;
        "soft-reboot")
            echo "Performing a soft reboot of userspace..."
            systemctl soft-reboot
            ;;
        *)
            echo "No valid option selected."
            ;;
    esac
}

# Call function to show menu
show_menu
