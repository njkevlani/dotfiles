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

function pacurl () {
  xdg-open "$(expac -S %u "$1")";
}

function cheat () {
  curl cheat.sh/$1
}

function hugonew () {
  given_path=${1}
  timestamp=`date +%Y%m%d`
  dir=
  if [[ "$given_path" == *\/* ]]; then
    dir=${given_path%/*}/
  fi
  file_name=${given_path##*/}
  path_with_timestamp="${dir}${timestamp}-${file_name}"

  hugo new $path_with_timestamp
}

BOLD="\[$(tput bold)\]"
RS="\[$(tput sgr0)\]"
NR="\[\033[38;5;9m\]"
NG="\[\033[38;5;10m\]"
NB="\[\033[38;5;12m\]"
R="${BOLD}${NR}"
G="${BOLD}${NG}"
B="${BOLD}${NB}"

PS1="${G}[${R}\$?${G}]-[${R}\h${G}]-[${B}\W${R}\$(parse_git_branch) \$(lsbytesum)MB${G}]-[${B}\\!${G}]-λ${RS} "

# Custom script are kept in this folder
PATH=$PATH:$HOME/xfce-dotFiles/scripts:$HOME/xfce-dotFiles/scripts/colorScripts

# Alias
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
alias py3Evn="source ~/.python/py3/bin/activate"
alias py2Evn="source ~/.python/py2/bin/activate"
alias vi="vim"
alias pkgByDate="expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort"
alias randPass="head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo ''"
alias tmp_pad="vim /tmp/tmp.txt"
alias list_files_sorted_by_size="find . -type f  -exec du -h {} + | sort -r -h"
alias cb="xmodmap ~/.Xmodmap_CB"
alias mv="mv -vi"
alias cbmk="xmodmap ~/.Xmodmap_CB"
function reminder () {
  sleep $1 && notify-send -u critical -i clock $2
}
# Disable Ctrl+s and Ctrl+q
stty -ixon

# Never delete history
HISTSIZE=
HISTFILESIZE=
HISTCONTROL=ignorespace

export MYSQL_PS1="\u@\h [\d]> "

if [ -f ~/.bash_secret ]
then
  source ~/.bash_secret
fi

export GOPATH=$HOME/code/go
PATH=${PATH}:${GOPATH}/bin

PATH=$PATH:$HOME/.cargo/bin

PY3ENV=$HOME/.python
PATH=${PATH}:${PY3ENV}/py3/bin

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
[[ -r "/usr/share/fzf/completion.bash" ]] && source /usr/share/fzf/completion.bash
[[ -r "/usr/share/fzf/key-bindings.bash" ]] && source /usr/share/fzf/key-bindings.bash
