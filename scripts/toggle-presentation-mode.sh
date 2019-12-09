#!/bin/bash

xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -T
pmode=$(xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode)
if [[ "$pmode" == "true" ]]; then
    text1="No sleep mode on"
    text2="The computer will stay awake"
else
    text1="No sleep mode off"
    text2="The computer will be suspended"
fi

time=3000
icon=cs-screensaver
notify-send -t $time -i "$icon"  "$text1" "$text2"
