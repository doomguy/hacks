#!/bin/bash
# Remeber to use: https://www.shellcheck.net
set -euo pipefail
IFS=$'\n\t'

# Uncomment for Debugging
#set -x

# Script to return status code of given urls

# 2DO:
# - Implement proper user agent handling

while IFS= read -r URL; do
  curl -k -s -o /dev/null -w "%{http_code}: %{url_effective}\n" --connect-timeout 10 "$URL"
done
