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
