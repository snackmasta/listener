stty_state=$(stty -g); stty raw -echo; (stty size; cat) | nc -lvnp 2002; stty "$stty_state"
