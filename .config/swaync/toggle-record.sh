#!/usr/bin/env bash

if pgrep -f wf-recorder > /dev/null; then
  "$HOME/dotfiles/.config/swaync/record.sh" stop
else
  "$HOME/dotfiles/.config/swaync/record.sh" start screen eDP-1 "$HOME/Videos/Screencasts/"
fi
