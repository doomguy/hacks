#!/bin/bash

# Remeber to use: https://www.shellcheck.net
set -euo pipefail
IFS=$'\n\t'

# Uncomment for Debugging
#set -x

# Search urlscan.io for a domain and check the http response code; filters pages with status 404

print_usage() {
  echo "Usage:"
  echo "\$ $0 example.com | tee example_com.log"
  exit
}

main() {
  curl -s "https://urlscan.io/api/v1/search/?q=$DOMAIN" \
   | jq '.results|.[].task.url' \
   | grep -iE "$DOMAIN/" \
   | xargs -I§ curl -s -o /dev/null -w "%{http_code}: %{url_effective}\n" § \
   | grep -v ^404
}

if [ $# = 1 ]; then
  if [ "$1" = "-h" ]; then
    print_usage
  else
    DOMAIN="$1"
    main
  fi
  exit
else
  print_usage
fi
