#!/bin/bash
stty_state=$(stty -g); 
while :
do
    stty raw -echo; 
    (stty size; cat) | nc -lvnp 2002; 
    stty "$stty_state";
done
