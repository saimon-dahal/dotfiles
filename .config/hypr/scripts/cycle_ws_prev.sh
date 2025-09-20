#!/usr/bin/env bash

nonempty=$(hyprctl workspaces -j | jq -r '.[] | select(.windows | length > 0) | .id' | sort -n)

current=$(hyprctl activeworkspace -j | jq -r '.id')

mapfile -t ws_array <<< "$nonempty"

for i in "${!ws_array[@]}"; do
    if [[ "${ws_array[i]}" == "$current" ]]; then
        idx=$i
        break
    fi
done

# Compute previous index (wrap around)
prev_idx=$(( (idx - 1 + ${#ws_array[@]}) % ${#ws_array[@]} ))

hyprctl dispatch workspace "${ws_array[$prev_idx]}"
