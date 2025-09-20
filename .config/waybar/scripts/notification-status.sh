#!/bin/bash

# Get swaync-client output
raw=$(swaync-client -swb | jq -r '.text, .tooltip, .alt')

count="$raw"
tooltip=$(swaync-client -swb | jq -r '.tooltip')

# Use bell only if count > 0
if [[ "$count" != "0" ]]; then
  icon="󱅫"
else
  icon="󰂚"  # fallback for no notifications
fi

# Output as JSON
echo "{\"text\": \"$icon $count\", \"tooltip\": \"$tooltip\"}"
