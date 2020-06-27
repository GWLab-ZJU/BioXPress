#!/usr/bin/env bash
set -ue
cd "$(readlink -f "$(dirname "${0}")")"
echo -e "\e[33mConfiguring wagon origin...\e[0m"
if [ -f "start.sh" ];then
	if [ "${1}" = "force" ];then
		rm "start.sh"
	elif [ "${1}" = "ignore" ];then
		echo -e "\033[031mWARNING: Directory not clear\033[0m"
		exit 0
	fi
fi
cp exec/__start.sh start.sh
if [ -e ENA-FQ.conf ];then
	echo "bindep=ascp">>wagon.conf
else
	if ! ls *.fq *.fastq *.fq.gz *.fastq.gz &>>/dev/null;then
		echo -e "\033[031mERROR: Please add your fastq file, or add FNA-FQ.conf.\033[0m"
		exit 1
	fi
fi
