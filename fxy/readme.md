
```
root@kali:~# fxy

[ FOXACID || Commando Script ]

Author: Doomguy (https://github.com/doomguy)

Commands:
  fxy cewl [s|ssl|tls] [SUBDIR]                 : cewl PROTO://RHOST+SUBDIR -w RHOST_cewl.txt
  fxy cme [smb]                                 : crackmapexec smb RHOST | tee
  fxy curl [s|ssl|tls] [SUBDIR]                 : curl -si PROTO://RHOST+SUBDIR | less
  fxy dirb [s|ssl|tls] [SUBDIR]                 : dirb PROTO://RHOST+SUBDIR | tee
  fxy (evil-)winrm [:id]                        : evil-winrm -i RHOST -u :id_user -p :id_pass
  fxy h(elp)                                    : Show this help
  fxy httpd|ws [port]                           : python3 -m http.server PORT
  fxy l(isten) [port]                           : nc -vlkp PORT
  fxy nikto [s|ssl|tls] [SUBDIR]                : nikto -host PROTO://RHOST+SUBDIR | tee
  fxy n(map) [full]                             : nmap -v -A (-p-) RHOST | tee
  fxy peas [version] [port]                     : Download *peas and serve via http.server
  fxy p(ing) [:count]                           : ping -c COUNT RHOST
  fxy r(host) [target]                          : Show/Set RHOST
  fxy smbpasswd [:id]                           : smbpasswd -r RHOST -U :id
  fxy wfuzz 
```
  
```
root@kali:~# fxy rhost webscantest.com
root@kali:~# fxy rhost
Environment:
  RHOST: webscantest.com
```
