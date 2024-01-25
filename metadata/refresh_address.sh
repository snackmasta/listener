jq '.website == [{"ip": "18.136.148.247", "port": "14968"}]' data_old.json > data.json; cat data.json > data_old.json
