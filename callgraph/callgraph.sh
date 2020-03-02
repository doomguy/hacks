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
  LURL="http://$domain"
  lookup
  LURL="https://$domain"
  lookup
done

# Graph footer
echo '}'
