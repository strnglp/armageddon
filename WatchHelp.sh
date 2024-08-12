#!/bin/bash
original_stty=$(stty -g)
trap "stty $original_stty; echo 'Exiting...'; exit 0" SIGINT EXIT
stty -echo -icanon time 0 min 0
clear
printf '\033[3J'
ARMDIR=$(echo ~/Armageddon)
mkdir -p $ARMDIR/ArmLogs
FILE="$ARMDIR/ArmLogs/help.txt"
touch $FILE

last_mod_time=0

while true; do
  current_mod_time=$(stat -f %m "$FILE")
  if [ "$current_mod_time" -gt "$last_mod_time" ]; then
    last_mod_time="$current_mod_time"
    clear
    printf '\033[3J'
    cat "$FILE"
    printf "<Ctrl-C to close>"
  fi
  read -r -s -n 1 key
done