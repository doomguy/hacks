#!/bin/zsh

if [ $(whoami) != "root" ]; then echo "Needs to be run as root: 'sudo $0'"; exit; fi

systemsetup -setnetworktimeserver pool.ntp.org
sntp -sS pool.ntp.org
