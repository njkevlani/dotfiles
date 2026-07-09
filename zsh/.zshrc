uname_out="$(uname -s)"
case "${uname_out}" in
Linux*) source ~/.config/zsh/linux.zsh ;;
Darwin*) source ~/.config/zsh/mac.zsh ;;
esac

source ~/.config/zsh/keybindings.zsh

# Uncomitted changes.
if [ -f ~/.config/zsh/misc.zsh ]; then
    source ~/.config/zsh/misc.zsh
fi

export EDITOR="nvim"
export MANPAGER='nvim +Man!'

# Consider / as wordchar.
# Add period (`.`) and slash (`/`) into WORDCHARS.
# This helps in seprating words by given chars when performing actions like backward-word.
WORDCHARS=${WORDCHARS//[.\/]/}



# python virtual env
alias py3="source $HOME/.local/share/py3-venv/bin/activate"

# Aliases
alias ls="ls --color --group-directories-first -F"
alias vi="nvim"
alias lg='nvim +"lua Snacks.lazygit()"'
alias kc='kubectl config use-context $(kubectl config get-contexts -o name | fzf)'
alias kubectlnvim='nvim +"lua require(\"kubectl\").open()"'

# Same as jq, but do not fail on invalid json.
alias jqsafe='jq -Rr "fromjson? // (\"\u001b[31m!!!un parsed - \u001b[0m\" + .)"'

# Convert json list to csv
alias jqcsv="jq -r '(.[0] | keys) as \$k | \$k, map([.[ \$k[] ]])[] | @csv'"

# Docker playground aliases.
alias doc_go="docker run --name go-play -d golang:1.23"

# Git in prompt.
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst

# Show hidden files in completion.
setopt globdots
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' formats '%F{blue}(%b)%f' # (main)

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

# Prompt like [0]-[dotfiles(main)]-λ
PROMPT='%B%F{10}[%F{9}%?%F{10}]-[%F{9}%1~${vcs_info_msg_0_}%F{10}]-λ%b%f '

# Show 󰜺 when output does not end with new line.
PROMPT_EOL_MARK=$'\U000f073a'

eval "$(mise activate zsh)"

# Enable fzf shell integration for things like history search.
source <(fzf --zsh)

# History settings
HISTFILE=~/.cache/zsh/history.txt
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.

# For completion.
autoload -Uz compinit && compinit

# Do not complete through the completion list.
unsetopt AUTO_MENU
setopt AUTO_CD

# Edit command in $EDITOR.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# MISC
# allow # comments in shell
setopt INTERACTIVE_COMMENTS

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    # Location of zsh-syntax-highlighting plgin on arch linux.
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    # Location for zsh-syntax-highlighting  plgin on fedora.
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    echo "did not load zsh-syntax-highlighting"
fi
