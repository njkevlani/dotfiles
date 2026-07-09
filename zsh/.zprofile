# Keep path unique
typeset -U path PATH

# Go setup
export GOPATH="$HOME/.local/share/go"
export PATH="$PATH:$GOPATH/bin"

# Rust setup
export CARGO_HOME="$HOME/.local/share/cargo"
export PATH="$PATH:$CARGO_HOME/bin"

# Local bin
export PATH="$PATH:$HOME/.local/bin"

export EDITOR="nvim"
export MANPAGER='nvim +Man!'

# OS-specific configurations
uname_out="$(uname -s)"
case "${uname_out}" in
  Linux*)  [ -f ~/.config/zsh/linux.profile.zsh ] && source ~/.config/zsh/linux.profile.zsh ;;
  Darwin*) [ -f ~/.config/zsh/mac.profile.zsh ] && source ~/.config/zsh/mac.profile.zsh ;;
esac

