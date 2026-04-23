alias vi='nvim'
alias ls="ls --color --group-directories-first -F"
alias grep='grep --color=auto'
alias kc='kubectl config use-context $(kubectl config get-contexts -o name | fzf)'

# Same as jq, but do not fail on invalid json.
alias jqsafe='jq -Rr "fromjson? // (\"\u001b[31m!!!un parsed - \u001b[0m\" + .)"'

# Convert json list to csv
# shellcheck disable=SC2154
alias jqcsv="jq -r '(.[0] | keys) as \$k | \$k, map([.[ \$k[] ]])[] | @csv'"

export PATH=$HOME/.local/bin/:$PATH

export EDITOR=nvim
export MANPAGER='nvim +Man!'

# Never delete history
export HISTSIZE=
export HISTFILESIZE=

# Search history with is already typed as prefix.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Don't record duplicates and ignore commands starting with a space
export HISTCONTROL=ignoreboth:erasedups

# Append to the history file immediately, don't overwrite it
shopt -s histappend

random_string() {
	length=${1:-7} # Default length is 7 if not provided
	tr -dc 'A-Za-z0-9' </dev/urandom | head -c "$length"
	echo # To add a newline after the string
}

# Change dir to the worktree chosen from fzf picker
wt_cd() {
	local list target
	list="$(wt --list)" || return
	target="$(printf '%s\n' "$list" | fzf --prompt='Worktrees > ' | cut -f2)"
	[[ -n "$target" ]] && cd -- "$target" || exit
}

# Remove worktree chosen from fzf picker
wt_rm() {
	local list target
	list="$(wt --list)" || return
	target="$(printf '%s\n' "$list" | fzf --prompt='Remove worktree > ' | cut -f1)"
	[[ -n "$target" ]] && wt --rm --branch "$target"
}

# Set ssh auth socket for ssh-agent service.
# Ref: https://wiki.archlinux.org/title/SSH_keys
if [[ -z "$SSH_AUTH_SOCK" ]]; then
	export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
fi

eval "$(mise activate bash)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

R="\[\033[1;38;5;9m\]"
G="\[\033[1;38;5;10m\]"
B="\[\033[1;38;5;12m\]"
RS="\[\033[0m\]"

source /usr/share/git/completion/git-prompt.sh
PS1="${G}[${R}\$?${G}]-[${B}\W${R}\$(__git_ps1 '(%s)')${G}]-λ${RS} "
