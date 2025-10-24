#!/bin/bash

# Function to restart yazi instances
yazi_restart() {
    if pgrep -x yazi >/dev/null; then
        local pids=($(pgrep -x yazi))
        local restarted=0
        
        for pid in "${pids[@]}"; do
            local current_pid=$pid
            local window_addr=""
            
            # Walk up the process tree to find a window
            while [[ $current_pid -gt 1 && -z "$window_addr" ]]; do
                window_addr=$(hyprctl clients -j | jq -r --arg pid "$current_pid" '.[] | select(.pid == ($pid | tonumber)) | .address' 2>/dev/null)
                
                if [[ -n "$window_addr" ]]; then
                    break
                fi
                
                current_pid=$(ps -o ppid= -p $current_pid 2>/dev/null | tr -d ' ')
                [[ -z "$current_pid" ]] && break
            done
            
            if [[ -n "$window_addr" ]]; then
                # Focus the window first
                hyprctl dispatch focuswindow address:$window_addr
                sleep 0.05
                
                # Kill the yazi process
                kill $pid
                sleep 0.15
                
                # Send command much faster
                if command -v ydotool >/dev/null; then
                    ydotool key 29:1 46:1 46:0 29:0
                    sleep 0.05
                    ydotool type --key-delay 0 "yazi"
                    sleep 0.05
                    ydotool key 28:1 28:0
                elif command -v wtype >/dev/null; then
                    wtype -M ctrl -P c -m ctrl
                    sleep 0.05
                    wtype -d 0 "yazi"
                    sleep 0.05
                    wtype -k Return
                fi
                
                ((restarted++))
            fi
        done
        
        printf "Restarted yazi in %d window(s)\n" "$restarted" >&2
    fi
}
