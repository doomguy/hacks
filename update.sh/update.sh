#!/usr/bin/env bash

# Upgrade system
pacman -Syu

# Upgrade atom
apm upgrade -c false

# pip
# python3 -m pip3 install --upgrade pip
# gem
gem update

# npm upgrade
npm update -g

# Homebrew
#brew update
#brew upgrade
#brew cleanup -s
#brew cask cleanup
