# Wagon loader
import os


class wagon:
    def __init__(self, name: str, ver: float, forward: list, path: str):
        self.name = name
        self.ver = ver
        self.forward = forward
        self.path = os.path.abspath(path)

    def __str__(self):
        return self.name + "," + str(self.ver)

    def __repr__(self):
        return self.__str__()

class wagonchain:
    def __init__(self):
        self.__index = 0
        self.list = []
        self.sorted = False
        self.llist = []

    def __contains__(self, item: wagon):
        return item in self.list

    def append(self, inwagon: wagon):
        self.list.append(inwagon)
        self.sorted = False

    def sort(self):
        self.self_check()
        listcopy = self.list.copy()
        self.llist = [[]]
        for i in range(len(listcopy)):
            if listcopy[i].forward == []:
                self.llist[0] = [listcopy.pop(i)]
                break
        Ended = False
        layer = 0

        def finddep(wagonobj: wagon) -> list:
            nonlocal listcopy
            retlst = []
            for wagonitem in listcopy:
                if wagonobj.name in wagonitem.forward:
                    retlst.append(wagonitem)
            return retlst

        while not Ended:
            layer += 1
            self.llist.append([])
            for wagoncurrlayerobj in self.llist[layer - 1]:
                deps = finddep(wagoncurrlayerobj)
                if deps == []:
                    continue
                for item in deps:
                    if not item in self.llist[layer]:
                        self.llist[layer].append(item)
            if self.llist[layer] == []:
                Ended = True
        self.llist=self.llist[0:-1]
        self.sorted = True

    def self_check(self):
        names = []
        for wagon_item in self.list:
            names.append(wagon_item.name)
        for wagon_item in self.list:
            for wagon_fwd in wagon_item.forward:
                if not wagon_fwd in names:
                    raise ValueError("Wagon " + str(wagon_fwd) + " needed.")
