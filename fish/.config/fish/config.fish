set -g fish_greeting

# Aliases
alias vi='nvim'
alias ls='ls --color --group-directories-first -F'
alias grep='grep --color=auto'
alias kc='kubectl config use-context (kubectl config get-contexts -o name | fzf)'

# Same as jq, but do not fail on invalid json.
alias jqsafe='jq -Rr '\''fromjson? // ("\u001b[31m!!!un parsed - \u001b[0m" + .)'\'''

# Convert json list to csv
alias jqcsv='jq -r '\''(.[0] | keys) as $k | $k, map([.[ $k[] ]])[] | @csv'\'''

fish_add_path $HOME/.local/bin

set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'

# SSH agent socket
if test -z "$SSH_AUTH_SOCK"
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
end

function fish_prompt
    set -l red (set_color --bold brred)
    set -l green (set_color --bold brgreen)
    set -l blue (set_color --bold brblue)
    set -l reset (set_color --reset)

    set -l last_status $status
    set -l cwd (prompt_pwd | path basename)
    set -l repo_branch (string trim (fish_vcs_prompt))

    echo -n "$green""[$red$last_status$green]-[$blue$cwd$red$repo_branch$green]-λ$reset "
end

# mise
mise activate fish | source

# fzf integration
fzf --fish | source
