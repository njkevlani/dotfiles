# get current branch in git repository
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        echo "(${BRANCH})"
    else
        echo ""
    fi
}

# Print sum size of current folder files.
function lsbytesum() {
    TotalBytes=0
    for Bytes in $(ls -l | grep "^-" | awk '{ print $5 }')
    do
        let TotalBytes=$TotalBytes+$Bytes
    done
    TotalMeg=$(echo -e "scale=3 \n$TotalBytes/1048576 \nquit" | bc)
    echo -n "$TotalMeg"
}

# PS1 time !!
PS1=$'\[\033[01;32m\][\[\033[01;31m\]$?\[\033[01;32m\]]-[\[\033[01;94m\]\w\[\033[01;31m\]`parse_git_branch` `lsbytesum`MB\[\033[01;32m\]]-[\[\033[01;94m\]\!\[\033[01;32m\]]-λ\[\033[0;0m\] '

# Custom script are kept in this folder
PATH=$PATH:/home/nilesh/xfce-dotFiles/scripts

# Alias
alias todo="vim /home/nilesh/.TODO"
alias ls="ls -A --group-directories-first --color=auto"

# Never delete history
HISTSIZE=
HISTFILESIZE=
