uname_out="$(uname -s)"
case "${uname_out}" in
    Linux*)  source ~/.config/zsh/linux.zsh;;
    Darwin*) source ~/.config/zsh/mac.zsh;;
esac

# Uncomitted changes.
if [ -f ~/.config/zsh/misc.zsh ]; then
    source ~/.config/zsh/misc.zsh
fi

export EDITOR="nvim"
export MANPAGER='nvim +Man!'

# Consider / as wordchar.
# This helps in seprating words by / when performing actions like backward-word.
WORDCHARS="${WORDCHARS/\//}"

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

# BINDKEY
# ⌥← for going back word by word.
bindkey "\e[1;3D" backward-word
# ⌥→ for going forward word by word.
bindkey "\e[1;3C" forward-word
# cmd+← for going at the beginning of the line.
bindkey "^[[1;9D" beginning-of-line
# cmd+→ for going at the end of the line.
bindkey "^[[1;9C" end-of-line
# Up arrow only goes up in history and not up in line when there are multiple lines in a command.
bindkey '^[[A' up-history
