# Set ssh auth socket for ssh-agent service.
# Ref: https://wiki.archlinux.org/title/SSH_keys
if [[ -z "$SSH_AUTH_SOCK" ]]; then
	export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
fi
