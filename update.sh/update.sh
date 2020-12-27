#!/usr/bin/env bash
# Remeber to use: https://www.shellcheck.net
set -euo pipefail
IFS=$'\n\t'
export LC_ALL=C

# Uncomment for Debugging
#set -x

# Check if root
if [ ! "$(id -u)" -eq 0 ]; then
    echo -e "\n[!] This needs to run as 'root'. Try 'sudo $0'"
    exit
fi 

## Operating Systems

# Debian/Ubuntu
if [ -f "$(which apt)" ] && [ -x "$(which apt)" ]; then
    echo -e "\n[*] Starting updates using 'apt'"
    apt update &&
    apt dist-upgrade -y
    #apt autoremove -y
fi

# CentOS/Fedora
if [ -f "$(which dnf)" ] && [ -x "$(which dnf)" ]; then
    echo -e "\n[*] Starting updates using 'dnf'"
    dnf update
elif [ -f "$(which yum)" ] && [ -x "$(which yum)" ]; then
    echo -e "\n[*] Starting updates using 'yum'"
    yum update
fi

# Arch/Manjaro
if [ -f "$(which pacman)" ] && [ -x "$(which pacman)" ]; then
    echo -e "\n[*] Starting updates using 'pacman'"
    pacman -Syu
fi

# macOS
if [ -f "$(which softwareupdate)" ] && [ -x "$(which softwareupdate)" ]; then
    echo -e "\n[*] Starting macOS updates using 'softwareupdate'"
    softwareupdate -i -a
fi

# macOS Homebrew
if [ -f "$(which brew)" ] && [ -x "$(which brew)" ]; then
    echo -e "\n[*] Starting Homewwbrew updates using 'brew'"
    brew update &&
    brew upgrade &&
    brew cleanup -s &&
    brew cask cleanup
fi

## Applications

# Python pip3
if [ -f "$(which pip3)" ] && [ -x "$(which pip3)" ]; then
    echo -e "\n[*] Starting Python pip updates using 'pip3'"
    pip3 install --upgrade pip &&
    for p in $(pip3 list -o --format freeze); do pip3 install -U ${p%%=*}; done &&
    pip3 check
fi

# Ruby gems
if [ -f "$(which gem)" ] && [ -x "$(which gem)" ]; then
    echo -e "\n[*] Starting ruby gem updates using 'gem'"
    gem update
fi

# Node.js npm upgrade
if [ -f "$(which npm)" ] && [ -x "$(which npm)" ]; then
    echo -e "\n[*] Starting npm updates using 'npm'"
    npm update -g
fi

# Upgrade Atom
if [ -f "$(which apm)" ] && [ -x "$(which apm)" ]; then
    echo -e "\n[*] Starting atom updates using 'apm'"
    apm upgrade -c false
fi

echo -e "\n[*] All done! Exiting.."
