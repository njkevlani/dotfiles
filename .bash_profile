[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.Xmodmap ]] && /usr/bin/xmodmap ~/.Xmodmap

if [ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ]; then
    startx
fi
