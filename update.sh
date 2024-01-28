Ip=$(host 0.tcp.ap.ngrok.io | grep -oP 'has address \K[^ ]+')
Port=$(curl localhost:4040/api/tunnels | jq '.tunnels[0].public_url' | awk -F':' '{print $3}' | tr -d '"')

curl -X PUT -d '{"port": '$Port', "ip": "'"$Ip"'"}' 'https://curronebox-default-rtdb.asia-southeast1.firebasedatabase.app/address.json' > /dev/null
