import sys,os

fw = open(".version")
localver = fw.readlines()
fw.close()
fw = open(".wagons/.version")
remotever = fw.readlines()
fw.close()
allitem = []
for item in localver:
    tmpver = item.split("\t")
    allitem.append([tmpver[0], float(tmpver[1]), 0.0])
for item in remotever:
    tmpver = item.split("\t")
    i = 0
    for i in range(len(allitem)):
        if allitem[i][0] == tmpver[0]:
            allitem[i][2] = float(tmpver[1])
            break
    if i == len(allitem)-1:
        allitem.append([tmpver[0], 0.0, float(tmpver[1])])
table = ['#S15', '#S10', '#S10', "Wagon;Local;Remote"]
if 'diffinstalled' in sys.argv[1:]:
    for enum in allitem:
        if enum[1] != enum[2] and enum[1] != 0 and enum[2] != 0:
            enum[1] = str(enum[1])
            enum[2] = str(enum[2])
            table.append(';'.join(enum))
elif 'fulldiff' in sys.argv[1:]:
    for enum in allitem:
        if enum[1] != enum[2]:
            enum[1] = str(enum[1])
            enum[2] = str(enum[2])
            table.append(';'.join(enum))
elif 'notinstalled' in sys.argv[1:]:
    for enum in allitem:
        if enum[1] == 0:
            enum[1] = str(enum[1])
            enum[2] = str(enum[2])
            table.append(';'.join(enum))
else:
    for enum in allitem:
        enum[1] = str(enum[1])
        enum[2] = str(enum[2])
        table.append(';'.join(enum))
fw=open("/tmp/__bioxp_version_diff.tmp","w")
fw.write('\n'.join(table))
fw.close()
os.system('python exec/__ylmktbl.py /tmp/__bioxp_version_diff.tmp')
os.remove('/tmp/__bioxp_version_diff.tmp')
