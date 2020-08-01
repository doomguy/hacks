#!/usr/bin/python3

import sys
import os

def main():   
    if len(sys.argv)<2:
      print("Usage: {} user.txt | sort -u > mylist.txt".format(sys.argv[0]))
      print("Script can handle entries of the following formats:")
      print("  John Doe")
      print("  Admin")
      print("  PeterParker:Spiderm4n")
      sys.exit()

    filepath = sys.argv[1]

    if not os.path.isfile(filepath):
      print("File {} does not exist. Exiting..".format(filepath))
      sys.exit()
  
    with open(filepath) as fp:
      for input in fp:
        line=input.strip() # Get rid of whitespaces
        #print(line) # Debug
        combo=line.split(':') # Support for combolist like entries: 'JohnDoe:s3cr3tp4$$w0rd"
        #print(userpart) # Debug
        nlist=combo[0].split(' ')
        #print(nlist) # Debug

        print(combo[0])      # Unmodified

        # If only one word is present, just print and continue with next entry
        if len(nlist) < 2:
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

        print("{}{}".format(nlist[0][0],nlist[1][0]))  # 1f1l
        print("{}{}".format(nlist[1][0],nlist[0][0]))  # 1l1f

        print("{}.{}".format(nlist[0][0],nlist[1][0]))  # 1f.1l
        print("{}.{}".format(nlist[1][0],nlist[0][0]))  # 1l.1f

        print("{}_{}".format(nlist[0][0],nlist[1][0]))  # 1f_1l
        print("{}_{}".format(nlist[1][0],nlist[0][0]))  # 1l_1f

        print("{}{}{}".format(nlist[0][0],nlist[1][0],nlist[1][1]))  # 1f1l2l

        if len(nlist[0]) > 2 and len(nlist[1]) > 2:
            print(nlist[0][0]+nlist[0][1]+nlist[0][2]+nlist[1][0]+nlist[1][1]+nlist[1][2]) # 1-3f1-3l

if __name__ == '__main__':
    main()
