if [ -f  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	# Location of zsh-syntax-highlighting plgin on arch linux.
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f   /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	# Location for zsh-syntax-highlighting  plgin on fedora.
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
	echo "did not load zsh-syntax-highlighting"
fi

# Set ssh auth socket for ssh-agent service.
# Ref: https://wiki.archlinux.org/title/SSH_keys
if [[ -z "$SSH_AUTH_SOCK" ]]; then
	export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
fi
