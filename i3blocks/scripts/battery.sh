#!/bin/bash

# Improved battery script for i3blocks with better charging detection

# Get battery information
BATTERY_INFO=$(acpi -b)
BATTERY_PERCENT=$(echo "$BATTERY_INFO" | grep -P -o '[0-9]+(?=%)')

# Check charging status multiple ways
CHARGING_ACPI=$(echo "$BATTERY_INFO" | grep -o "Charging\|Full\|Discharging\|Not charging")
CHARGING_SYSFS=$(cat /sys/class/power_supply/AC/online 2>/dev/null || echo "0")

# Determine charging status
if [[ $CHARGING_ACPI == "Charging" ]] || [[ $CHARGING_SYSFS == "1" ]]; then
    CHARGING_STATUS="Charging"
elif [[ $CHARGING_ACPI == "Full" ]]; then
    CHARGING_STATUS="Full"
else
    CHARGING_STATUS="Discharging"
fi

# Set default color (from Catppuccin Mocha theme)
if (( BATTERY_PERCENT < 20 )); then
    COLOR="#f38ba8"  # Red for low battery
else
    COLOR="#cdd6f4"  # Normal color
fi

# Set icons based on status
case $CHARGING_STATUS in
    "Charging")
        ICON="󰂄"  # Charging icon
        COLOR="#a6e3a1"  # Green when charging
        ;;
    "Full")
        ICON="󰂅"  # Full battery icon
        COLOR="#a6e3a1"  # Green when full
        ;;
    *)
        # Set discharging icons based on battery percentage
        if (( BATTERY_PERCENT >= 90 )); then
            ICON="󰁹"
        elif (( BATTERY_PERCENT >= 80 )); then
            ICON="󰂂"
        elif (( BATTERY_PERCENT >= 70 )); then
            ICON="󰂁"
        elif (( BATTERY_PERCENT >= 60 )); then
            ICON="󰂀"
        elif (( BATTERY_PERCENT >= 50 )); then
            ICON="󰁿"
        elif (( BATTERY_PERCENT >= 40 )); then
            ICON="󰁾"
        elif (( BATTERY_PERCENT >= 30 )); then
            ICON="󰁽"
        elif (( BATTERY_PERCENT >= 20 )); then
            ICON="󰁼"
        else
            ICON="󰁻"
        fi
        ;;
esac

# Output for i3blocks
echo "<span color='$COLOR'>$ICON $BATTERY_PERCENT%</span>"

# Optional: for debugging
# echo "<span color='$COLOR'>$ICON $BATTERY_PERCENT% ($CHARGING_STATUS)</span>"
