import sys
import sys
import time
from datetime import datetime
from signal import signal, SIGINT
from sys import exit

import psutil


def handler(a, b):
    global fw
    global original
    sys.stdout = original
    fw.close()
    print('SIGINT or CTRL-C detected. Exiting.')
    exit(0)


original = sys.stdout
signal(SIGINT, handler)
fw = open(sys.argv[1], "w", 1)
sys.stdout = fw
print(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
print("Physical CPU: " + str(psutil.cpu_count()) + "With Logical CPU: " + str(psutil.cpu_count(logical=True)) + '\n')

psutil.cpu_percent(percpu=True)
while True:
    print(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    print("Current CPU per-cent: " + '%, '.join(map(str, psutil.cpu_percent(percpu=True))) + '%')
    vm = psutil.virtual_memory()
    print("Virtual Memory: " + str(vm.used) + '/' + str(vm.total) + '=' + str(vm.percent) + '%')
    sm = psutil.swap_memory()
    print("Swap Memory: " + str(sm.used) + '/' + str(sm.total) + '=' + str(sm.percent) + '%')
    du = psutil.disk_usage('.')
    print("Disk Usage: " + str(du.used) + '/' + str(du.total) + '=' + str(du.percent) + '%')
    io = psutil.disk_io_counters()
    print("Disk total IO: " + str(io.read_count) + "/" + str(io.read_count))
    dio = psutil.disk_io_counters(True)
    for dictitem in dio.items():
        print("Disk " + dictitem[0] + " IO: " + str(dictitem[1].read_count) + "/" + str(dictitem[1].read_count))
    print()
    time.sleep(1)
