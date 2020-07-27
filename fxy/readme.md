
```
root@kali:~# fxy
Commands:
  fxy cme [smb]                                 : crackmapexec smb RHOST | tee
  fxy curl [s|ssl|tls] [SUBDIR]                 : curl -si PROTO://RHOST+SUBDIR | less
  fxy dirb [s|ssl|tls] [SUBDIR]                 : dirb PROTO://RHOST/SUBDIR | tee
  fxy e(nv)                                     : Show environment
  fxy (evil-)winrm [:id]                        : evil-winrm -i RHOST -u :id_user -p :id_pass
  fxy h(elp)                                    : Show this help
  fxy httpd|www [port]                          : python3 -m http.server PORT
  fxy l|isten [port]                            : nc -vlkp PORT
  fxy nikto [s|ssl|tls] [SUBDIR]                : nikto -host RHOST+SUBDIR | tee
  fxy n(map) [full]                             : nmap -v -A (-p-) RHOST | tee
  fxy peas [version] [port]                     : Download *peas and serve via http.server
  fxy p(ing) [:count]                           : ping -c COUNT RHOST
  fxy r(host)                                   : Set RHOST
  fxy smbpasswd [:id]                           : smbpasswd -r RHOST -U :id
```
  
```
root@kali:~# fxy rhost example.com
root@kali:~# fxy e
Environment:
  RHOST: example.com
```
