from wagons.wagons import *

mywc = wagonchain()
for dir in os.listdir():
    if dir.endswith('.bioxp') and os.path.isfile(dir + "/wagon.conf") and os.path.isfile(dir + "/exec/configure.sh"):
        print("\033[033mLoading BioXPress wagon " + dir + " ...\033[0m", end='')
        tmpname = ""
        tmpver = 0.0
        tmpfwd = []
        tmpbindep = []
        tmpfiledep = []
        tmpinc = []
        for line in open(dir + "/wagon.conf"):
            line = line.strip()
            if tmpname.startswith('#'):
                continue
            if tmpname == "" and line.startswith("name="):
                tmpname = line[5:]
            elif tmpver == 0.0 and line.startswith("ver="):
                tmpver = float(line[4:])
            if line.startswith("forward="):
                tmpfwd.append(line[8:])
            elif line.startswith("bindep="):
                tmpbindep.append(line[7:])
            elif line.startswith("filedep="):
                tmpfiledep.append(line[8:])
            elif line.startswith("inc="):
                tmpinc.append(line[4:])
        if tmpname == "" and tmpver == 0.0:
            raise ValueError("wagon.conf corrupted.")
        tmpwagon = wagon(tmpname, tmpver, tmpfwd, tmpinc, dir, tmpbindep, tmpfiledep)
        mywc.append(tmpwagon)
        print("\033[032mSUCCESS!\033[0m")
if mywc.list == []:
    print("\033[031mERROR: No wagon in this directory. Please execute 'bioxp init' first.\033[0m")
print("\033[033mSorting and generating dependencies...\033[0m")
mywc.sort()
if len(mywc.llist[0]) != 1:
    raise ValueError("A BioXPress should have precisely 1 leading wagon, instead of " + str(len(mywc.llist[0])))
fw = open(".version", "w")
for item in mywc.list:
    fw.write(item.name + "\t" + str(item.ver) + "\n")
fw.close()
fw = open(".filedep", "w")
fw.write("\n".join(mywc.filedep))
fw.close()
fw = open(".bindep", "w")
fw.write("\n".join(mywc.bindep))
fw.close()
