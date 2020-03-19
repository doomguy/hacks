#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

USER_AGENT='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36'

print_usage() {
  echo "Usage:"
  echo "\$ $0 http://example.com"
  exit
}

main () {
  echo "$DOMAIN"
  #curl -sLv -A $USER_AGENT $DOMAIN 2>&1 | grep -Ei '(^> (GET|Host)|Location:)' | grep -v '^*' | sed 's,^<,  <,g'
  wget -O- -U "$USER_AGENT" "$DOMAIN" 2>&1 | grep -i '^Location:'
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

main
