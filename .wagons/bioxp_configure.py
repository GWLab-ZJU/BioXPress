from readwagons import *
import sys
print("\033[033mSort complete, configuring...\033[0m")
for i in range(len(mywc.llist)):
    print("\033[033mConfiguring step "+str(i)+" ...\033[0m")
    for item in mywc.llist[i]:
        if os.system("bash '"+item.path+"'/configure.sh "+sys.argv[0]) !=0:
            raise ChildProcessError("Configuration for "+str(item)+" failed!")
print("\033[033mConfigure complete, generating start.sh...\033[0m")
fw=open("start.sh","a")
fw.write("bash '"+mywc.llist[0][0].path+"'/start.sh\n")
fw.close()
print("\033[033mstart.sh generated. Program finished.\033[0m")
