#!/bin/bash
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

time_value=$(echo "$json_data" | jq -r '.["00-15-5D-38-01-09"].LastSeen' | cut -d ' ' -f1)
echo "$time_value"
