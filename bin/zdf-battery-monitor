#!/bin/bash

# Run by a systemd timer every 30 seconds to alert if battery is low

BATTERY_THRESHOLD=20
NOTIFICATION_FLAG="/run/user/$UID/zero_battery_notified"

# Query battery info only once
BAT_INFO=$(upower -i "$(upower -e | grep 'BAT')")
BATTERY_LEVEL=$(echo "$BAT_INFO" | grep -E "percentage" | grep -o '[0-9]\+%' | sed 's/%//')
BATTERY_STATE=$(echo "$BAT_INFO" | grep -E "state" | awk '{print $2}')

send_notification() {
  # Single quotes avoid shell history expansion issues with !
  notify-send -u critical -i battery-caution -t 30000 \
    '󱐋 Time to recharge!' "Battery is down to ${1}%"
}

# Only alert when discharging and below/equal threshold
if [[ "$BATTERY_STATE" == "discharging" && "$BATTERY_LEVEL" -le "$BATTERY_THRESHOLD" ]]; then
  # Send notification only if we haven't already done so for this level
  if [[ ! -f "$NOTIFICATION_FLAG" ]] || [[ "$(cat "$NOTIFICATION_FLAG")" -gt "$BATTERY_LEVEL" ]]; then
    send_notification "$BATTERY_LEVEL"
    echo "$BATTERY_LEVEL" > "$NOTIFICATION_FLAG"
  fi
else
  # Reset flag when charging or above threshold
  rm -f "$NOTIFICATION_FLAG"
fi
