#!/bin/sh
# Give PPA name as an argument, e.g. ppa:oibaf/graphics-drivers

name1="$(echo "$1"|cut -d: -f2|cut -d/ -f1)"
name2="$(echo "$1"|cut -d/ -f2)"

awk '$1 == "Package:" { if (a[$2]++ == 0) print $2; }' \
/var/lib/apt/lists/*"$name1"*"$name2"*Packages |
xargs dpkg-query -W -f='${Status} ${Package}\n' 2>/dev/null  | awk '/^[^ ]+ ok installed/{print $4}'
