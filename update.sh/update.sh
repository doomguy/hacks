#!/usr/bin/env bash
# Remeber to use: https://www.shellcheck.net
set -euo pipefail
IFS=$'\n\t'
export LC_ALL=C

# Uncomment for Debugging
#set -x

## Operating Systems

# Debian/Ubuntu
if [ -f "$(which apt)" ] && [ -x "$(which apt)" ]; then
    echo "[*] Starting updates using 'apt'"
    apt update &&
    apt dist-upgrade -y
    #apt autoremove -y
fi

# CentOS/Fedora
if [ -f "$(which dnf)" ] && [ -x "$(which dnf)" ]; then
    echo "[*] Starting updates using 'dnf'"
    dnf update
elif [ -f "$(which yum)" ] && [ -x "$(which yum)" ]; then
    echo "[*] Starting updates using 'yum'"
    yum update
fi

# Arch/Manjaro
if [ -f "$(which pacman)" ] && [ -x "$(which pacman)" ]; then
    echo "[*] Starting updates using 'pacman'"
    pacman -Syu
fi

# macOS Homebrew
if [ -f "$(which brew)" ] && [ -x "$(which brew)" ]; then
    echo "[*] Starting updates using 'brew'"
    brew update &&
    brew upgrade &&
    brew cleanup -s &&
    brew cask cleanup
fi

## Applications

# Upgrade atom
if [ -f "$(which apm)" ] && [ -x "$(which apm)" ]; then
    echo "[*] Starting atom updates using 'apm'"
    apm upgrade -c false
fi

# Python pip
# pip
# python3 -m pip3 install --upgrade pip

# ruby gems
if [ -f "$(which gem)" ] && [ -x "$(which gem)" ]; then
    echo "[*] Starting ruby gem updates using 'gem'"
    gem update
fi

# npm upgrade
if [ -f "$(which npm)" ] && [ -x "$(which npm)" ]; then
    echo "[*] Starting npm updates using 'npm'"
    npm update -g
fi