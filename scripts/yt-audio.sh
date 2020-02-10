#!/bin/bash

notify-send -i youtube "Playing Audio" "$(xclip -o)"
mpv --ytdl-format=251 "$(xclip -o)" \
  || mpv --fs "$(xclip -o)" \
  || notify-send -i stock_dialog-error "Failed to Play"
