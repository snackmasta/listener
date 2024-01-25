#!/bin/bash

num= 

jq '.clients += {"client_1":{"num": '$num' "id": "new_client", "state": 0.9}}' data_old.json > data.json

sleep 1
cp data.json data_old.json
