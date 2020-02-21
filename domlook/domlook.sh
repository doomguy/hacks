#!/bin/bash
# Remeber to use: https://www.shellcheck.net
set -euo pipefail
IFS=$'\n\t'

# Uncomment for Debugging
#set -x

# Usage
# $ echo "example.com" | ./domlook.sh
# example.com/93.184.216.34/2606:2800:220:1:248:1893:25c8:1946
# $ cat domains.lst | ./domlook.sh
# example.com/93.184.216.34/2606:2800:220:1:248:1893:25c8:1946
# examples.com/54.211.255.162

while IFS= read -r domain; do
  ip4=$(dig +short "$domain" @8.8.8.8 | sed ':a;N;$!ba;s/\n/,/g')
  ip6=$(dig AAAA +short "$domain" @8.8.8.8 | sed ':a;N;$!ba;s/\n/,/g')
  echo "$domain/$ip4/$ip6" | sed 's,/$,,g'
done
