#!/usr/bin/env bash
set -ue
if ls *.bioxp&>>/dev/null&& [ -f "start.sh" ];then
	echo -e "\033[031mERROR: Directory not clear.
	Please execute 'bioxp distclean' to remove old files if you want to start a new experiment.\033[0m"
	exit 1
fi
if ! [ -f "wagons.conf" ];then
	echo -e "\033[031mERROR: wagons.conf not found.\033[0m"
	exit 1
fi
cat wagons.conf|grep -v '^#'|while read line;do
	cp -r .wagons/"${line}".bioxp .
done
cp exec/__start.sh start.sh
python .wagons/wagonfiles_init.py
