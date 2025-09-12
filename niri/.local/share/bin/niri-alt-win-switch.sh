#!/usr/bin/env bash

# A script to toggle comment in niri config for alt-win swap.

CONFIG="$HOME/.config/niri/config.kdl"

UNCOMMENTED_LINE='            options "altwin:swap_alt_win"'
COMMENTED_LINE='            // options "altwin:swap_alt_win"'

# Check if the line is currently commented
if grep -q "^$COMMENTED_LINE" "$CONFIG"; then
  # Uncomment the line
  sed -i "s|$COMMENTED_LINE|$UNCOMMENTED_LINE|" "$CONFIG"
  notify-send "Set swap_alt_win"
elif grep -q "^$UNCOMMENTED_LINE" "$CONFIG"; then
  # Comment the line
  sed -i "s|$UNCOMMENTED_LINE|$COMMENTED_LINE|" "$CONFIG"
  notify-send "Unset swap_alt_win"
else
  echo "Could not find the expected line in $CONFIG."
  exit 1
fi
