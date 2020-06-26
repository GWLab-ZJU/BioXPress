from readwagons import *
import sys
print("\033[033mChecking dependencies...\033[0m",end='')
if os.system("bash '"+os.path.abspath(os.path.dirname(sys.argv[0]))+"'/chkdep.sh") !=0:
    raise EnvironmentError("Dependency check failed.")
print("\033[032mSUCCESS!\033[0m")
print("\033[032mSort complete, configuring...\033[0m")
for i in range(len(mywc.llist)):
    print("\033[033mConfiguring step "+str(i)+" ...\033[0m",end='')
    for item in mywc.llist[i]:
        if os.system("bash '"+item.path+"'/configure.sh "+sys.argv[1]) !=0:
            raise ChildProcessError("Configuration for "+str(item)+" failed!")
    print("\033[032mSUCCESS!\033[0m")
if sys.argv[1]=="ignore" and os.path.isfile("start.sh"):
    print("\033[032mstart.sh already generated. Program finished.\033[0m")
    exit(0)
print("\033[033mConfigure complete, generating start.sh...\033[0m",end='')
fw=open("start.sh","a")
fw.write("bash '"+mywc.llist[0][0].path+"'/start.sh\n")
fw.close()
print("\033[032mSUCCESS!\033[0m")
print("\033[032mstart.sh generated. Program finished.\033[0m")
