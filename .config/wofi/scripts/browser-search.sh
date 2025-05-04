#!/bin/bash

# Get the search query passed from Wofi
search_query="$1"
echo "hello"

# Check if the search query is empty
if [[ -z "$search_query" ]]; then
    exit 0  # Exit if no query is provided
fi

# Define the browser to use
BROWSER="firefox"  # Change this to your preferred browser

# Check if the search query corresponds to an application
if command -v "$search_query" &>/dev/null; then
    # If it's an app, run it
    exec "$search_query"
else
    # If it's not an app, perform a web search
    if pgrep -x "$BROWSER" > /dev/null; then
        # If the browser is already running, open a new tab with the search query
        $BROWSER "https://www.google.com/search?q=$search_query"
    else
        # If no browser is open, launch the browser and perform the search
        $BROWSER "https://www.google.com/search?q=$search_query" &
    fi
fi
