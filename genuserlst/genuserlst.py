#!/usr/bin/python3

import sys
import os

def main():
   
    if len(sys.argv)<2:
      print("Usage: {} user.txt | sort -u > mylist.txt".format(sys.argv[0]))
      print("Script can handle entries of usersnames in the following formats:")
      print("  John Doe")
      print("  Admin")
      print("  PeterParker:Spiderm4n")
      sys.exit()

    filepath = sys.argv[1]

    if not os.path.isfile(filepath):
      print("File {} does not exist. Exiting...".format(filepath))
      sys.exit()
  
    with open(filepath) as fp:
      for input in fp:
        line=input.strip()
        #print(line) # Debug
        userpart=line.split(':') # Support for combolists 'johnDoe:s3cr3tp4$$w0rd"
        #print(userpart) # Debug
        nlist=userpart[0].split(' ')
        #print(nlist) # Debug

        print(userpart[0])      # Unmodified

        # If only one word is given, just print and continue with next entry
        if len(nlist)<2:
          continue 

        print("{} {}".format(nlist[1],nlist[0]))  # l f
        print(nlist[0])  # f
        print(nlist[1])  # l
        print("{}{}".format(nlist[0],nlist[1]))  # f+l
        print("{}{}".format(nlist[1],nlist[0]))  # l+f
          
        print("{}.{}".format(nlist[0],nlist[1]))  # f.l
        print("{}.{}".format(nlist[1],nlist[0]))  # l.f
           
        print("{}_{}".format(nlist[0],nlist[1]))  # f_l
        print("{}_{}".format(nlist[1],nlist[0]))  # l_f
           
        print("{}{}".format(nlist[0][0],nlist[1]))  # 1f+l
        print("{}{}".format(nlist[1][0],nlist[0]))  # 1l+f
           
        print("{}.{}".format(nlist[0][0],nlist[1]))  # 1f.l
        print("{}.{}".format(nlist[1][0],nlist[0]))  # 1l.f

        print("{}_{}".format(nlist[0][0],nlist[1]))  # 1f_l
        print("{}_{}".format(nlist[1][0],nlist[0]))  # 1l_f

        print("{}.{}".format(nlist[0],nlist[1][0]))  # f.1l
        print("{}.{}".format(nlist[1],nlist[0][0]))  # l.1f

        print("{}_{}".format(nlist[0],nlist[1][0]))  # f_1l
        print("{}_{}".format(nlist[1],nlist[0][0]))  # l_1f

        print("{}.{}".format(nlist[0][0],nlist[1][0]))  # 1f.1l
        print("{}.{}".format(nlist[1][0],nlist[0][0]))  # 1l.1f

        print("{}_{}".format(nlist[0][0],nlist[1][0]))  # 1f_1l
        print("{}_{}".format(nlist[1][0],nlist[0][0]))  # 1l_1f

        print("{}.{}.".format(nlist[0][0],nlist[1][0]))  # 1f.1l.
        print("{}.{}.".format(nlist[1][0],nlist[0][0]))  # 1l.1f.


if __name__ == '__main__':
    main()
