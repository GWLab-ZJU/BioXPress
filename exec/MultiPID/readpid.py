import os
import signal
import psutil

mypids = {}
tmppids = {p.pid: p.info for p in psutil.process_iter(['ppid'])}
for item in tmppids.items():
    # [[PPID PID]]
    ppid = item[1]['ppid']
    if not ppid in mypids:
        mypids[ppid] = []
    self = mypids[ppid]
    self.append(item[0])
    mypids[ppid] = self
mysamples=[]

class sample_pid:
    def __init__(self, name: str, recpath: str, type: str, pid: int):
        self.name = name
        self.recpath = recpath
        self.type = type
        if type == "BUSB":
            self.pid = pid
        else:
            self.pid = psutil.Process(pid)

    def kill_force(self):
        if type == "BUSB":
            os.system("bkill -r "+str(self.pid))
            return
        cpid = self.pid.children(True)
        cpid.append(self.pid)
        for p in cpid:
            p.send_signal(signal.SIGKILL)

    def kill_term(self):
        if type == "BUSB":
            os.system("bkill "+str(self.pid))
            return
        cpid = self.pid.children(True)
        cpid.append(self.pid)
        for p in cpid:
            p.send_signal(signal.SIGTERM)

    def kill_INTR(self):
        if type == "BUSB":
            os.system("bkill "+str(self.pid))
            return
        cpid = self.pid.children(True)
        cpid.append(self.pid)
        for p in cpid:
            p.send_signal(signal.SIGINT)


def readdir():
    if os.path.exists('./reg/'):
        for item in os.listdir('./reg/'):
            if item.endswith(".doing"):
                print(print("\tReading " + item))
                fr = open(item, 'r')
                pid = fr.readlines()
                fr.close()
                for line in pid:
                    if line.startswith('BUSB'):
                        mysamples.append(sample_pid(line[0:-6],os.path.abspath('./reg/'+line),"BSUB",int(line[4:])))
                        print("BSUBpid: " + line)
                    else:
                        mysamples.append(sample_pid(line[0:-6], os.path.abspath('./reg/' + line), "", int(line)))
                        print("PID: " + line)
            elif item.endswith(".done"):
                print(print("\t" + item[0:-5] +" done"))
            elif item.endswith(".nstart"):
                print(print("\t" + item[0:-6] +" waiting"))
