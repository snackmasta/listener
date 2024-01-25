#!/bin/bash

jq --argjson counter "$(jq '.clients | length' data_old.json)" \
  '.clients += {("client_\($counter + 1)"): {"num": ($counter + 1), "id": "computer_\($counter + 1)", "state": 0}}' data_old.json > data.json

#delete last client 
#jq 'del(.clients[.clients | keys_unsorted[-1]])' data_old.json > data.json; sleep 1; cat data.json > data_old.json

sleep 1 

cp data.json data_old.json 
