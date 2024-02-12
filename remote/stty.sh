#!/bin/bash
stty_state=$(stty -g); 
while :
do
    stty raw -echo time 0; 
    (stty size; cat) | nc -lvnp 2002; 
    stty "$stty_state";
    echo "Listening stopped. Press 'r' to restart or 'e' to exit."
    read -n 1 choice
    if [ "$choice" = "e" ]; then
        exit 0
    fi
done
