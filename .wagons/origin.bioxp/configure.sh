#!/usr/bin/env bash
set -ue
cd "$(readlink -f "$(dirname "${0}")")"
echo -e "\e[33mConfiguring original...\e[0m"
if [ -f "origin.conf" ];then
	if [ "${1}" = "force" ];then
		rm "origin.conf"
	elif [ "${1}" = "ignore" ];then
				echo -e "\033[031mWARNING: Directory not clear. Will use old configuration files.\033[0m"
		exit 0
	else
		echo -e "\033[031mERROR: Directory not clear.
		Please execute 'bioxp reconfigure' to remove old configuration files.\033[0m"
		exit 1
	fi
fi
ln -sf exec/__start.sh start.sh
