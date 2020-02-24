#!/bin/bash
# Tail nse scan.log and highlight hits
find /opt/rapid7/nexpose/nse/scans/ -type f -iname "scan.log" | xargs tail -f | sed --unbuffered -e 's/\(.*VULNERABLE.*\)/\o033[31m\1\o033[39m/'
