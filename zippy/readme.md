```
$ cat hello.py
print("Hello World!")

$ cat run.py 
from zipfile import ZipFile
with ZipFile('hello.zip') as myzip:
    with myzip.open('hello.py', mode='r', pwd=bytes('pass123', 'utf-8')) as myfile:
                    exec(myfile.read())

# Create zip file with password "pass123"
$ zip -P pass123 hello.zip hello.py

# Create python one-liner
$ echo "python3 -c \"import base64; exec(base64.b64decode('"$(base64 -w0 run.py)"'))\""

# Run it
$ python3 -c 'import base64; exec(base64.b64decode("ZnJvbSB6aXBmaWxlIGltcG9ydCBaaXBGaWxlCndpdGggWmlwRmlsZSgnaGVsbG8uemlwJykgYXMgbXl6aXA6CiAgICB3aXRoIG15emlwLm9wZW4oJ2hlbGxvLnB5JywgbW9kZT0ncicsIHB3ZD1ieXRlcygncGFzczEyMycsICd1dGYtOCcpKSBhcyBteWZpbGU6CiAgICAgICAgICAgICAgICAgICAgZXhlYyhteWZpbGUucmVhZCgpKQo="))'

# Output
Hello World!
```
