#!/usr/bin/env bash
set -ue
echo -e "\033[031mWARNING! THIS WILL REMOVE ALL FILES GENERATED IN THIS PROJECT AND CONFIGURATION FILES! FOR COMMON CLEAN-UP TASKS, PLEASE EXECUTE 'bioxp clean'.\033[0m"
read -p 'Y/N>' ANS
#if [ "${ANS}" = "Y" ];then
	rm -rf *.bioxp/ start.sh # *.conf
#fi
