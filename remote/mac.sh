#!/bin/bash
url="https://curronebox-default-rtdb.asia-southeast1.firebasedatabase.app"
json_data=$(curl -s "$url/Online.json")
count=$(echo "$json_data" | jq 'length')
# echo "Number of key-value pairs: $count"

# Scan 0 diff Client time
for (( i = 0; i <= $count-1; i++ )); do
  # echo $i
  # echo "$json_data" | jq -r 'keys['$i']'
  current_time=($(date "+%H"| sed 's/^0*//') $(date "+%M"| sed 's/^0*//'))
  mac_address=$(echo "$json_data" | jq -r 'keys['$i']')
  time_value=$(echo "$json_data" | jq -r '.["'$mac_address'"].LastSeen' | cut -d ' ' -f1)
  client_hours=$((10#$(echo "$time_value" | cut -d':' -f1)))
  client_minutes=$((10#$(echo "$time_value" | cut -d':' -f2)))
  # echo $client_hours 
  # echo $client_minutes 
  # echo ${current_time[0]}
  # echo ${current_time[1]}
  compare_time=$(( (client_hours - ${current_time[0]}) * 60 + client_minutes - ${current_time[1]} ))
  # echo $compare_time
  if [ "$compare_time" -ge -1 ] && [ "$compare_time" -le 1 ]; then
    brand=$(curl -s "$url/clients/$mac_address/recon/Brand.json")
    username=$(curl -s "$url/clients/$mac_address/recon/User.json")
    echo "$username $brand is Online"
    if [[ ! $(termux-notification-list | jq -e '.[].tag | select(. == "client-'$i'")') ]]; then
    # Execute your command here
    termux-media-player play /data/data/com.termux/files/home/storage/shared/Notifications/rikka.mp3>    /dev/null 
    termux-notification -i client-$i -c "$i $username $brand $mac_address"
    fi
  else
    termux-notification-remove client-$i
  fi
done
