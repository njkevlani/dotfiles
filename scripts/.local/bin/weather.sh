#!/bin/bash

data=$(curl wttr.in/Bhavnagar?format="%t|%C")
temperature=$(echo "$data" | grep -o ".*|" | sed "s/|//g" | sed "s/\+//g")
condition=$(echo "$data" | grep -o "|.*" | sed "s/|//g")

if [[ "$temperature" == *"°C"* ]]; then
    text="$temperature"
else
    text="···"
fi

echo -n "<img>/usr/share/icons/Papirus-Light/16x16/panel/weather-clouds.svg</img>"
#echo -n "<txtclick>xfce4-panel --plugin-event=genmon-9:refresh:bool:true</txtclick>"
echo -n "<click>xfce4-panel --plugin-event=genmon-9:refresh:bool:true</click>"
echo -n "<txt>$text</txt>"
echo -n "<tool>$condition</tool>"

# todo: icon according to condition
# todo: click to refresh

