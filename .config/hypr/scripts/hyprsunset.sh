#!/usr/bin/env bash

TEMP=4500
PIDFILE="/tmp/hyprsunset.pid"

if [[ -f "$PIDFILE" ]]; then
    PID=$(cat "$PIDFILE")
    if kill -0 "$PID" 2>/dev/null; then
        # Reset color and kill the process
        hyprsunset -i
        kill "$PID"
        rm "$PIDFILE"
        notify-send "Hyprsunset" "Disabled color temperature"
    else
        rm "$PIDFILE"
        notify-send "Hyprsunset" "Cleanup: old PID removed"
    fi
else
    # Start Hyprsunset with temperature
    hyprsunset -t "$TEMP" &
    echo $! > "$PIDFILE"
    notify-send "Hyprsunset" "Enabled color temperature ($TEMP K)"
fi
