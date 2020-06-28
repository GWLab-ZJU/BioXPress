from readwagons import *
import sys
print("\033[032mSort complete, configuring...\033[0m")
for i in range(len(mywc.llist)):
    for item in mywc.llist[i]:
        print("\033[033mInitializing step " + item.name + " ...\033[0m")
        if os.path.isfile(item.path+"/exec/init.sh"):
            os.system("bash '"+item.path+"'/exec/init.sh")
print("\033[032mProgram finished.\033[0m")
