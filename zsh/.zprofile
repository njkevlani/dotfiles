# Keep path unique
typeset -U path PATH

# Go setup
export GOPATH="$HOME/.local/share/go"
export PATH="$GOPATH/bin:$PATH"

# Rust setup
export CARGO_HOME="$HOME/.local/share/cargo"
export PATH="$CARGO_HOME/bin:$PATH"

# Local bin
export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
export MANPAGER='nvim +Man!'

# OS-specific configurations
uname_out="$(uname -s)"
case "${uname_out}" in
  Linux*)  [ -f ~/.config/zsh/linux.profile.zsh ] && source ~/.config/zsh/linux.profile.zsh ;;
  Darwin*) [ -f ~/.config/zsh/mac.profile.zsh ] && source ~/.config/zsh/mac.profile.zsh ;;
esac

