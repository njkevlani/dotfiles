#!/usr/bin/env bash

# A script to close window if any focused or prompt for shutdown/logout.

# Get focused window ID
focused_window=$(niri msg focused-window | grep '(focused)')

# Check if focused window exists
if [[ -n "$focused_window" && "$focused_window" != "null" ]]; then
    niri msg action close-window
else
    action_shutdown="Shutdown"
    action_logout="Logout"
    action_lock="Lock"
    action=$(printf "%s\n" "$action_shutdown" "$action_logout" "$action_lock" | rofi -no-config -dmenu -l 3 -theme-str 'window {width: 200;}' -theme-str 'inputbar {enabled: false;}')

    if [[ "$action" == "$action_shutdown" ]]; then
        systemctl poweroff
    elif [[ "$action" == "$action_logout" ]]; then
        niri msg action quit -s
    elif [[ "$action" == "$action_lock" ]]; then
        swaylock
    fi
fi
