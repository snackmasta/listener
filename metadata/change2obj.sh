#!/bin/bash

ip="11.22.33.44"
port=2220

#jq '.website.ip="11.12.40" | .website.port=4002' data_old.json > data.json
jq '.website.ip="'$ip'" | .website.port='$port'' data_old.json > data.json

sleep 1

cat data.json > data_old.json
