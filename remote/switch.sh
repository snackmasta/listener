read -p "Enter the ID of the client: " id
read -p "Enter the state of the client: " state

client_URL="https://curronebox-default-rtdb.asia-southeast1.firebasedatabase.app/client_$id/state.json"
curl -X PUT -d $state "$client_URL" > /dev/null

#curl -X PUT -d '{"id": "computer_1","MAC": 1,"state": '$state'}' "$client_URL" > /dev/null