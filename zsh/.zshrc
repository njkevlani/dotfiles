uname_out="$(uname -s)"
case "${uname_out}" in
    Linux*)  source ~/.config/zsh/linux.zsh;;
    Darwin*) source ~/.config/zsh/mac.zsh;;
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

# gopath setup
export GOPATH="$HOME/.local/share/go"
export PATH="$PATH:$GOPATH/bin"

# ruest setup
export CARGO_HOME=$HOME/.local/share/cargo
PATH=$PATH:$CARGO_HOME/bin

# Aliases
alias ls="ls --color --group-directories-first -F"
alias vi="nvim"
alias lg="lazygit"
alias kc='kubectl config use-context $(kubectl config get-contexts -o name | fzf)'

# Docker playground aliases.
alias doc_go="docker run --name go-play -d golang:1.23"

# Git in prompt.
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' formats '%F{blue}(%b)%f' # (main)

# Prompt like [0]-[dotfiles(main)]-λ
PROMPT='%F{red}[%f%?%F{red}]%f-%F{red}[%f%1~${vcs_info_msg_0_}%F{red}]%f-λ '

# Do not put % at the end of output.
PROMPT_EOL_MARK=''

# Enable fzf shell integration for things like history search.
source <(fzf --zsh)

# History settings
HISTFILE=~/.cache/zsh/history.txt
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# For completion.
autoload -Uz compinit && compinit

# Do not complete through the completion list.
unsetopt AUTO_MENU
setopt AUTO_CD

# MISC
# allow # comments in shell
setopt INTERACTIVE_COMMENTS
