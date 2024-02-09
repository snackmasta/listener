url="https://curronebox-default-rtdb.asia-southeast1.firebasedatabase.app"
json_data=$(curl -s "$url/Online.json")
count=$(echo "$json_data" | jq 'length')
# echo "Number of key-value pairs: $count"

# Scan 0 diff Client time
for (( i = 0; i <= $count-1; i++ )); do
  # echo $i
  # echo "$json_data" | jq -r 'keys['$i']'
  current_time=($(date "+%H") $(date "+%M"))
  mac_address=$(echo "$json_data" | jq -r 'keys['$i']')
  time_value=$(echo "$json_data" | jq -r '.["'$mac_address'"].LastSeen' | cut -d ' ' -f1)
  client_hours=$(echo "$time_value" | cut -d':' -f1 | sed 's/^0*//')
  client_minutes=$(echo "$time_value" | cut -d':' -f2 | sed 's/^0*//')
  compare_time=$(( (client_hours - ${current_time[0]}) * 60 + client_minutes - ${current_time[1]} ))
  # echo $compare_time
  if [ "$compare_time" -ge -1 ] && [ "$compare_time" -le 1 ]; then
    echo "$mac_address is Online"
  fi
done