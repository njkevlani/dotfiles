[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.Xmodmap ]] && /usr/bin/xmodmap ~/.Xmodmap

if [ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ]; then
    echo "startxfce4" > ~/.xinitrc && startx
elif [ -z "$DISPLAY" -a $XDG_VTNR -eq 2 ]; then
    echo "exec i3" > ~/.xinitrc && startx
fi
