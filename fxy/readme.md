
```
root@kali:~# fxy

[ FOXACID || Commando Script ][ Doomguy: https://github.com/doomguy ]

Available commands:
  fxy cewl [s|ssl|tls] [subdir]                 : cewl PROTO://RHOST+SUBDIR -w RHOST_cewl.txt
  fxy cme [smb]                                 : crackmapexec smb RHOST | tee
  fxy creds [add user:pass]                     : Show/Add creds
  fxy curl [s|ssl|tls] [subdir]                 : curl -si PROTO://RHOST+SUBDIR | less
  fxy dirb [s|ssl|tls] [subdir]                 : dirb PROTO://RHOST+SUBDIR | tee
  fxy (evil-)winrm [cid]                        : evil-winrm -i RHOST -u :cid_user -p :cid_pass
  fxy h(elp)                                    : Show this help
  fxy httpd|ws [port]                           : python3 -m http.server PORT
  fxy hydra [service] [port] [username]         : hydra brute force (ssh, ftp, smb)
  fxy (i)conv|convert [file]                    : iconv -f UTF-16LE -t UTF-8 FILE -o FILE.conv
  fxy l(isten) [port]                           : ncat -vlkp PORT
  fxy nfs|showmount                             : showmount -e RHOST
  fxy nikto [s|ssl|tls] [subdir]                : nikto -host PROTO://RHOST+SUBDIR | tee
  fxy n(map) [full]                             : nmap -v -A (-p-) RHOST | tee
  fxy pass(word)                                : Show machine password
  fxy peas [version] [port]                     : Download *peas and serve via http.server
  fxy p(ing) [count]                            : ping -c COUNT RHOST
  fxy r(host) [target]                          : Show/Set RHOST
  fxy rpc(client) [cid] [domain] [cmd]          : rpcclient
  fxy smbpasswd [cid]                           : smbpasswd -r RHOST -U :cid_user
  fxy ssh [cid] [port]                          : sshpass -e ssh :cid_user@RHOST -p PORT
  fxy weevely [gen|help]                        : weevely php shell
  fxy wfuzz                                     : wfuzz | tee
```
  
```
root@kali:~# fxy rhost webscantest.com
root@kali:~# fxy rhost
  RHOST: webscantest.com
root@kali:~# fxy nmap
> nmap -v -A webscantest.com -oA webscantest.com_nmap_2020-07-29_121952
Run command? (y/N): 
```
