#!/bin/bash
# Remeber to use: https://www.shellcheck.net
set -euo pipefail
IFS=$'\n\t'

# Uncomment for Debugging
#set -x

# Create graphviz file for requests path
# Usage: cat domains.lst | ./callgraph | dot -Tpng -o graph.png

# 2DO: Catch redirect loops

if [ "${USER_AGENT:-}" ]; then
  UA="$USER_AGENT"
else
  UA="callgraph"
fi

lookup() {
  while [ "$LURL" ]; do
    set +o pipefail
    REDIR=$(curl -ski -A "$UA" --max-time 10 "$LURL" | grep -i ^Location: | sed 's/^Location: //gi' | sed 's/\r$//')
    set -o pipefail

    # fix missing domain
    if [ "$REDIR" ] && [[ "$REDIR" =~ ^/.* ]]; then
      REDIR="${LURL}${REDIR}"
    fi

    if [ "$REDIR" ]; then
      echo "\"$LURL\" -> \"$REDIR\";"
    else
      echo "\"$LURL\";"
    fi
      LURL="$REDIR"
  done
}

# Graph header
echo -e "digraph G {\nrankdir=LR;\nnode [shape=box];\n"

while IFS= read -r domain; do
  # domain http
  LURL="http://$domain"
  lookup

  # domain https
  LURL="https://$domain"
  lookup

  IP4=$(dig @8.8.8.8 +short "$domain" | tail -n1)

  # ip4 http  
  LURL="http://$IP4"
  lookup

  # ip4 https
  LURL="https://$IP4"
  lookup

#  IP6=$(dig @8.8.8.8 AAAA +short www.microsoft.com | tail -n1)
#
#  # ip6 http  
#  LURL="http://$IP6"
#  lookup
#
#  # ip6 https
#  LURL="https://$IP6"
#  lookup

done

# Graph footer
echo '}'
