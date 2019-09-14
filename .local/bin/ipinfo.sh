#!/usr/bin/bash
# savage

# get IP ADDRESS data and return JSON response
curl https://ipinfo.io/$1/json

# it is then possible to pipe results to jq for parsing
# i.e. `curl https://ipinfo.io/$1/json | jq .city,.postal,.org`

