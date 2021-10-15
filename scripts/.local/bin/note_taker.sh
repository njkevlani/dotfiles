#!/bin/sh

note_file="$HOME/notes/note-$(date +%Y-%m-%d).md"
echo $note_file

if [ ! -f $note_file ]; then
  echo "# Notes for $(date +%Y-%m-%d)" > $note_file
fi

$EDITOR -c "norm Go" \
  -c "norm Go## $(date +%H:%M)" \
  -c "norm G2o" \
  -c "norm zz" \
  -c "startinsert" $note_file

