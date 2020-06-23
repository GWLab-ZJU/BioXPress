from wagons.wagons import *
import os

mywc = wagonchain()
for dir in os.listdir():
    if dir.endswith('.bioxp') and os.path.isfile(dir + "/wagon.conf") and os.path.isfile(dir + "/configure.sh"):
        print("\033[033mLoading BioXPress wagon " + dir + " ...\033[0m")
        tmpname = ""
        tmpver = 0.0
        tmpfwd = []
        for line in open(dir + "/wagon.conf"):
            line = line.strip()
            if tmpname == "" and line.startswith("name="):
                tmpname = line[5:]
            elif tmpver == 0.0 and line.startswith("ver="):
                tmpver = float(line[4:])
            if line.startswith("forward="):
                tmpfwd.append(line[8:])
        if tmpname == "" and tmpver == 0.0:
            raise ValueError("wagon.conf corrupted.")
        tmpwagon = wagon(tmpname, tmpver, tmpfwd, dir)
        mywc.append(tmpwagon)
print("\033[033mLoad complete, sorting...\033[0m")
mywc.sort()
print("\033[033mSort complete, configuring...\033[0m")
for i in range(len(mywc.llist)):
    print("\033[033mConfiguring step "+str(i)+" ...\033[0m")
    for item in mywc.llist[i]:
        if os.system("bash '"+item.path+"'/configure.sh") !=0:
            raise ChildProcessError("Configuration for "+str(item)+" failed!")
print("\033[033mConfigure complete, generating start.sh...\033[0m")
fw=open("start.sh","a")
fw.write("bash '"+mywc.llist[0][0].path+"'/start.sh\n")
fw.close()
print("\033[033mstart.sh generated. Program finished.\033[0m")
