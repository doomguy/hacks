#!/bin/bash
# Remeber to use: https://www.shellcheck.net
set -euo pipefail
IFS=$'\n\t'

# Uncomment for Debugging
#set -x

# Script to return status code of given urls/files

# Usage: 
#  cat urls.txt | ./httpstat.sh
#  > curl $LINE
#  cat files.txt | ./httpstat.sh http://example.com | grep -vE "(404|403)"
#  > curl http://example.com/$LINE

# 2DO:
# - Implement proper user agent handling

if [ "$#" -eq 1 ]; then
  DOMAIN="$1/"
else
  DOMAIN=""
fi

while IFS= read -r LINE; do
  if [[ "$LINE" =~ ^\./.*$ ]]; then
    LINE=$(echo "$LINE" | cut -d"/" -f2-)  
  fi

  curl -k -s -o /dev/null -w "%{http_code}: %{url_effective}\n" --connect-timeout 10 "$DOMAIN$LINE"
done
