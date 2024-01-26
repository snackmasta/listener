#!/bin/bash

declare -a connections=()
stty_state=$(stty -g)
stty raw -echo

while true; do
    # Accept incoming connection and store details in array
    connection_info=$( (stty size; timeout 1 cat) | nc -lvnp 2002 )
    connections+=("$connection_info")

    # Display menu of available connections
    clear
    echo "=== Incoming Connections ==="
    for ((i=0; i<${#connections[@]}; i++)); do
        echo "$i. ${connections[i]}"
    done
    echo "q. Quit"
    
    # Prompt user to choose a connection
    read -p "Select a connection (or 'q' to quit): " choice

    # Check if user wants to quit
    if [ "$choice" == "q" ]; then
        break
    fi

    # Check if the choice is a valid index
    if [ "$choice" -ge 0 ] && [ "$choice" -lt "${#connections[@]}" ]; then
        # Connect to the selected client using netcat
        selected_connection=$(echo "${connections[$choice]}" | awk '{print $NF}')  # Extract IP and port
        nc $selected_connection
    else
        echo "Invalid choice. Please enter a valid index or 'q' to quit."
    fi
done

stty "$stty_state"
