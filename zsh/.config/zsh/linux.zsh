if [ -f  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	# Location of zsh-syntax-highlighting plgin on arch linux.
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f   /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	# Location for zsh-syntax-highlighting  plgin on fedora.
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
	echo "did not load zsh-syntax-highlighting"
fi

source ~/.config/zsh/linux-keybindings.zsh
