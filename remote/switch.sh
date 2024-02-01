read -p "Enter the ID of the client: " id
read -p "Enter the state of the client: " state

count=$((id - 1))

# Get client the Parent Value of the client as an array
MAC=($(curl -s https://curronebox-default-rtdb.asia-southeast1.firebasedatabase.app/clients.json | jq -r 'keys[]')) 
echo ${MAC[$count]}

client_URL="https://curronebox-default-rtdb.asia-southeast1.firebasedatabase.app/clients/${MAC[$count]}/state.json"
curl -s -X PUT -d $state "$client_URL" > /dev/null