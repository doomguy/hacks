#!/bin/bash
ping "$1" 2>&1 | while IFS= read -r line; do printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$line"; done # | grep -v 'bytes from'
