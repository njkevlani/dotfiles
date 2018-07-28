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
#PS1=$'\[\033[01;32m\][\[\033[01;31m\]$?\[\033[01;32m\]]-[\[\033[01;94m\]\w\[\033[01;31m\]`parse_git_branch` `lsbytesum`MB\[\033[01;32m\]]-[\[\033[01;94m\]\!\[\033[01;32m\]]-λ\[\033[0;0m\] '

PS1=$'\[\033[01;32m\][\[\033[01;31m\]$?\[\033[01;32m\]]-[\[\033[01;94m\]\w\[\033[01;31m\]`parse_git_branch` `lsbytesum`MB\[\033[01;32m\]]-[\[\033[01;94m\]\!\[\033[01;32m\]]➜\[\033[0;0m\] '

# Custom script are kept in this folder
PATH=$PATH:/home/nilesh/xfce-dotFiles/scripts:/home/nilesh/xfce-dotFiles/scripts/colorScripts

# Alias
alias todo="vim /home/nilesh/.TODO"
alias ls="ls --group-directories-first --color=auto"
alias grep="grep --color"
alias :q="exit"
alias global_ip="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias local_ip="ip addr | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
alias topRAM="ps aux --no-headers | awk '{print \$4 \"% \"  \$11}' | sort -rn | head -n 10"
alias pyServer="local_ip && python -m http.server"
alias historyStat="history | tr -s ' ' | cut -d ' ' -f3 | sort | uniq -c | sort -n | tail | perl -lane 'print \$F[1], \"\t\", \$F[0], \" \", \"▄\" x (\$F[0] / 12)'"
alias historyStatBasic="history | awk '{CMD[\$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a; }' | grep -v \"./\" | column -c3 -s \" \" -t | sort -nr | nl | head -n10"
alias ytMusic="youtube-dl --extract-audio --audio-format mp3"

# Never delete history
HISTSIZE=
HISTFILESIZE=
