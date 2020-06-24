fw=open(".version")
localver=fw.readlines()
fw.close()
fw=open(".wagons/.version")
remotever=fw.readlines()
fw.close()
localdict={}
remotedict={}
for item in localver:
    tmpver=item.split("\t")
    localdict[tmpver[0]]=float(tmpver[1])
for item in remotever:
    tmpver=item.split("\t")
    remotedict[tmpver[0]]=float(tmpver[1])
while len(remotedict)>0:
    tmpver=remotedict.popitem()
    if tmpver[0] in localdict:
        locver=localdict[tmpver[0]]
        if locver<tmpver[1]:
            print("Find obsolute package '"+tmpver[0]+"', local: "+str(locver)+" with remote"+str(tmpver[1]))
    else:
        print("Package '"+tmpver[0]+"' not installed")
