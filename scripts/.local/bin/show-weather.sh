#!/bin/bash
time=3000
icon=/usr/share/icons/Papirus-Dark/24x24/panel/weather-many-clouds.svg
data=$(curl wttr.in/?format="%t|%C")
text1=$(echo "$data" | grep -o ".*|" | sed "s/|//g" | sed "s/\+//g")
text2=$(echo "$data" | grep -o "|.*" | sed "s/|//g")
notify-send -t $time -i "$icon"  "$text1" "$text2"

