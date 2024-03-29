# Read the new IP address
new_ip=$(host 0.tcp.ap.ngrok.io | grep -oP 'has address \K[^ ]+')

# Read the new port
new_port=$(curl localhost:4040/api/tunnels | jq '.tunnels[0].public_url' | awk -F':' '{print $3}' | tr -d '"')

curl -X PUT -d '{"port": '$new_port', "ip": "'$new_ip'"}' 'https://curronebox-default-rtdb.asia-southeast1.firebasedatabase.app/address.json' > /dev/null

echo -e "\e[34mUpdated data.json with IP: $new_ip and Port: $new_port\e[0m"
