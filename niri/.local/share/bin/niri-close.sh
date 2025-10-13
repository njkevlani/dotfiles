#!/usr/bin/env bash

# A script to close window if any focused or prompt for shutdown/logout.

# Get focused window ID
focused_window=$(niri msg focused-window | grep '(focused)')

# Check if focused window exists
if [[ -n "$focused_window" && "$focused_window" != "null" ]]; then
    niri msg action close-window
else
    prompt=$(uptime -p | sed -e 's/up/Uptime:/' \
        -e 's/ weeks\?/w/' \
        -e 's/ days\?/d/' \
        -e 's/ hours\?/h/' \
        -e ' s/ minutes\?/m/' \
        -e 's/,//g')

    action_shutdown="Shutdown"
    action_logout="Logout"
    action_lock="Lock"
    action_suspend="Suspend"
    action=$(printf "%s\n" "$action_shutdown" "$action_logout" "$action_lock" "$action_suspend" | rofi -dmenu -p "${prompt}" -theme ~/.config/rofi/themes/spotlight-dark-session-menu.rasi)

    case "${action}" in
    "${action_shutdown}") systemctl poweroff ;;
    "${action_logout}") niri msg action quit -s ;;
    "${action_lock}") swaylock ;;
    "${action_suspend}") systemctl suspend ;;
    esac
fi
