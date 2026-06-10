# Setup homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/libtool/libexec/gnubin:$PATH"

source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Use like
# echo 'https://google.com
# https://mail.google.com' | openlinks
alias openlinks='xargs -n 1 open'
alias brew_caveats="brew info --json --installed | jq -r 'map(select(.caveats) | \"====\npkg=\(.name)\n\n\(.caveats)\") | .[]'"

export XDG_CONFIG_HOME="$HOME/.config"
