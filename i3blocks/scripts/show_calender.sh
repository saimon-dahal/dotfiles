

# Debug log file
LOG_FILE=~/.config/dotfiles/i3blocks/scripts/calendar_debug.log

# Show icon
echo "<span font='12'></span>"

# On click (any mouse button)
if [ "$BLOCK_BUTTON" ]; then
    echo "Button clicked" >> $LOG_FILE

    # Check if gsimplecal is running using wmctrl
    if wmctrl -l | grep -q "Gsimplecal"; then
        echo "gsimplecal is running, killing it" >> $LOG_FILE
        pkill -f "gsimplecal"
    else
        echo "gsimplecal is not running, launching it" >> $LOG_FILE
        gsimplecal &
        sleep 0.3
        wmctrl -r "gsimplecal" -e 0,1000,40,-1,-1
    fi
fi


