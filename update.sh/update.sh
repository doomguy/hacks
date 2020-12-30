#!/usr/bin/env bash
# Remeber to use: https://www.shellcheck.net
#set -euo pipefail
IFS=$'\n\t'
export LC_ALL=C

# Uncomment for Debugging
#set -x

# txtstuff
bold=$(tput bold)
normal=$(tput sgr0)

# Check if root
if [ ! "$(id -u)" -eq 0 ]; then
    echo "${bold}[!] This script needs to run as 'root'. Try 'sudo $0'${normal}"
    exit
fi 

## Operating Systems

# Debian/Ubuntu
if [ -f "$(which apt)" ] && [ -x "$(which apt)" ]; then
    echo -e "${bold}\n[*] Starting updates using 'apt'${normal}"
    apt update &&
    apt dist-upgrade -y &&
    apt-get check &&
    echo -e "${bold}\n[*] Removing old packages using 'apt autoremove'${normal}"
    apt autoremove
fi

# CentOS/Fedora
if [ -f "$(which dnf)" ] && [ -x "$(which dnf)" ]; then
    echo -e "${bold}\n[*] Starting updates using 'dnf'${normal}"
    dnf update
elif [ -f "$(which yum)" ] && [ -x "$(which yum)" ]; then
    echo -e "${bold}\n[*] Starting updates using 'yum'${normal}"
    yum update
fi

# Arch/Manjaro
if [ -f "$(which pacman)" ] && [ -x "$(which pacman)" ]; then
    echo -e "${bold}\n[*] Starting updates using 'pacman'${normal}"
    pacman -Syu

    echo -e "${bold}\n[*] Removing orphaned packages using 'pacman'${normal}"
    #set +e
    pacman -Qtdq | pacman -Rns -
    #set -e
fi

# macOS
if [ -f "$(which softwareupdate)" ] && [ -x "$(which softwareupdate)" ]; then
    echo -e "${bold}\n[*] Starting macOS updates using 'softwareupdate'${normal}"
    softwareupdate -i -a
fi

# macOS Homebrew
if [ -f "$(which brew)" ] && [ -x "$(which brew)" ]; then
    echo -e "${bold}\n[*] Starting Homebrew updates using 'brew'${normal}"
    brew update &&
    brew upgrade &&
    brew cleanup -s &&
    brew cask cleanup
fi

## Applications

# Python pip3
if [ -f "$(which pip3)" ] && [ -x "$(which pip3)" ]; then
    echo -e "${bold}\n[*] Starting Python pip updates using 'pip3'${normal}"
    pip3 install --upgrade pip &&
    for p in $(pip3 list -o --format freeze); do pip3 install -U "${p%%=*}"; done &&
    
    echo -e "${bold}\n[*] Installing missing dependencies using 'pip3 check'${normal}"
    pip3 check | grep 'is not' | awk '{print $4}' | cut -d, -f1 | xargs -i% pip3 install %
fi

# Ruby gems
if [ -f "$(which gem)" ] && [ -x "$(which gem)" ]; then
    echo -e "${bold}\n[*] Starting ruby gem updates using 'gem'${normal}"
    gem update
fi

# Node.js npm upgrade
if [ -f "$(which npm)" ] && [ -x "$(which npm)" ]; then
    echo -e "${bold}\n[*] Starting Node.js updates using 'npm'${normal}"
    npm update -g
fi

# Upgrade Atom
if [ -f "$(which apm)" ] && [ -x "$(which apm)" ]; then
    echo -e "${bold}\n[*] Starting atom updates using 'apm'${normal}"
    apm upgrade -c false
fi

echo -e "${bold}\n[*] All done! Exiting..${normal}"
