#!/bin/bash
DOMAIN="$1"
USER_AGENT='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36'

echo "$DOMAIN"
#curl -sLv -A $USER_AGENT $DOMAIN 2>&1 | grep -Ei '(^> (GET|Host)|Location:)' | grep -v '^*' | sed 's,^<,  <,g'
wget -O- -U "$USER_AGENT" "$DOMAIN" 2>&1 | grep -i '^Location:'
