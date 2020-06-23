from wagons.wagons import *
import os

mywc = wagonchain()
for dir in os.listdir():
    if dir.endswith('.bioxp') and os.path.isfile(dir + "/wagon.conf") and os.path.isfile(dir + "/self-check.sh"):
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
mywc.sort()
