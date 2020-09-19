#!/usr/bin/env bash

for i in $(ls -1 */readme.md); do echo -n "$i:"; sed -n '2p' $i; done | sed 's,/readme.md,,' | column -t -s':'
