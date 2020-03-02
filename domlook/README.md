# domlook.sh
Script to query multiple domains and output in grepable format.

## Usage
```
$ echo "example.com" | ./domlook.sh
example.com/93.184.216.34/2606:2800:220:1:248:1893:25c8:1946

$ cat domains.lst | ./domlook.sh 
twitter.com/104.244.42.129,104.244.42.1
linkedin.com/108.174.10.10/2620:109:c002::6cae:a0a
facebook.com/157.240.27.35/2a03:2880:f13f:83:face:b00c:0:25de
microsoft.com/40.76.4.15,40.112.72.205,40.113.200.201,104.215.148.63,13.77.161.179

$ assetfinder example.com | ./domlook.sh
```
