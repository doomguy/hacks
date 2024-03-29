#!/bin/bash
# Check out: https://github.com/garabik/grc
# apt install grc

# Make aliases
cd /usr/share/grc; ls -1 conf.* | sed 's,conf\.,,g' | xargs -I % echo "alias %='grc %'" > ~/.grc_aliases

# Put into bashrc
echo 'source ~/.grc_aliases' >> ~/.bashrc
