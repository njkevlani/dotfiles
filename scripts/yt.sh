#!/bin/bash

notify-send -i youtube "Playing Video" "$(xclip -o)"
mpv --ytdl-format='bestvideo[height<=1080]+bestaudio/best[height<=1080]' --fs "$(xclip -o)" \
  || mpv --fs "$(xclip -o)" \
  || notify-send -i stock_dialog-error "Failed to Play"
