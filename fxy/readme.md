
```
root@kali:~# fxy
Commands:
  fxy cme [smb]                                 : crackmapexec smb RHOST | tee
  fxy curls [SUBDIR]                            : curl -ski https://RHOST/SUBDIR | less
  fxy curl [SUBDIR]                             : curl -si http://RHOST/SUBDIR | less
  fxy dirb [s|https|ssl|tls] [SUBDIR]           : dirb PROTO://RHOST/SUBDIR | tee
  fxy e(nv)                                     : Show environment
  fxy (evil-)winrm [:id]                        : evil-winrm -i RHOST -u :id_user -p :id_pass
  fxy h(elp)                                    : Show this help
  fxy httpd|www [port]                          : python3 -m http.server PORT
  fxy linpeas [port]                            : Download linpeas and serve via http.server
  fxy l|isten [port]                            : nc -vlkp PORT
  fxy nikto                                     : nikto -host RHOST | tee
  fxy n(map) [full]                             : nmap -v -A (-p-) RHOST | tee
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
