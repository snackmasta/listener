#!/bin/bash

# Define the JSON data
json_data='{
  "00-15-5D-38-01-09": {
    "LastSeen": "20:32:14 Thursday, 08 February 2024"
  },
  "3C-A0-67-66-D6-05": {
    "LastSeen": "07:36:02 Wednesday, 07 February 2024"
  },
  "AC-12-03-FC-5C-EC": {
    "LastSeen": "11:32:12 Friday, 09 February 2024"
  },
  "F4-6A-DD-6A-CF-4F": {
    "LastSeen": "08:02:59 Wednesday, 07 February 2024"
  }
}'

# Parse the JSON data and assign each component to variables
while IFS= read -r line; do
    # Extract MAC address and LastSeen timestamp
    mac=$(echo "$line" | jq -r 'keys[]')
    last_seen=$(echo "$line" | jq -r '.LastSeen')

    # Extract day, month, year, time, and date
    day=$(date -d "$(echo "$last_seen" | cut -d ',' -f2)" "+%A")
    month=$(date -d "$(echo "$last_seen" | cut -d ',' -f2)" "+%B")
    year=$(echo "$last_seen" | awk '{print $NF}')
    time=$(echo "$last_seen" | cut -d ' ' -f1)
    date=$(echo "$last_seen" | cut -d ',' -f1 | cut -d ' ' -f3-)

    # Output variables
    echo "MAC Address: $mac"
    echo "Day: $day"
    echo "Month: $month"
    echo "Year: $year"
    echo "Time: $time"
    echo "Date: $date"
    echo "-------------------------------------"
done <<< "$(echo "$json_data" | jq -c '.[]')"
