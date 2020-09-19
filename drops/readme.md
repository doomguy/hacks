# drops
Dropshell/Command Execution Vulnerability CLI client similar to weevely.

## Features
* GET/POST
* Colorful prompt :)
* Uploading/downlaoding of files
* Supports for "less <file>" (will actually cat the file and run less locally)
* Local commands via "!" (Try "pwd" vs "!pwd")
* Debug switch to see what is called
* Remove lines before and after output

## Usage
```
./drops.sh <get|post> example.com/file.php <params> <rm-lines-before> <rm-lines-after>
```
```
./drops.sh get localhost/get.php cmd= 1 1
```
