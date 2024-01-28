#!/bin/bash

# Read the new IP address
new_ip=$(host 0.tcp.ap.ngrok.io | grep -oP 'has address \K[^ ]+')

# Read the new port
new_port=$(curl localhost:4040/api/tunnels | jq '.tunnels[0].public_url' | awk -F':' '{print $3}' | tr -d '"')

# Create a JSON string with the new IP and port
# json_data="{\"ip_address\":\"$new_ip\",\"port\":\"$new_port\",\"id\":\"$id\"}"

# jq to update new IP and port
old_data=./metadata/data_old.json
new_data=./metadata/data.json

jq '.website.ip="'$new_ip'" | .website.port='$new_port'' "$old_data" > "$new_data"
sleep 1
cp "$new_data" "$old_data"

# Update GitHub
#git add .
#git commit -m "Update data.json with IP: $new_ip and Port: $new_port"
#git push

curl -X PUT -d '{"port": '$new_port', "ip": "'$new_ip'"}' 'https://curronebox-default-rtdb.asia-southeast1.firebasedatabase.app/address.json' > /dev/null

echo -e "\e[34mUpdated data.json with IP: $new_ip and Port: $new_port\e[0m"
