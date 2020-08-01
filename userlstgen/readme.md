```
# cat john.txt 
John Doe
```
```
# ./genuserlst.py 
Usage: ./genuserlst.py user.txt | sort -u > mylist.txt
Script can handle entries of the following formats:
  John Doe
  Admin
  PeterParker:Spiderm4n
```
```
# ./genuserlst.py john.txt 
John Doe
Doe John
John
Doe
JohnDoe
DoeJohn
John.Doe
Doe.John
John_Doe
Doe_John
JDoe
DJohn
J.Doe
D.John
J_Doe
D_John
John.D
Doe.J
John_D
Doe_J
J.D
D.J
J_D
D_J
J.D.
D.J.
JohDoe
```
