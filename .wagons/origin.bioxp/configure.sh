#!/usr/bin/env bash
set -ue
cd "$(readlink -f "$(dirname "${0}")")"
echo -e "\e[33mConfiguring wagon origin...\e[0m"
mkdir -p reg
if [ -e ENA_FQ.conf ] ;then
	if cat wagon.conf|grep 'bindep=ascp' &>>/dev/null;then
		echo "bindep=ascp">>wagon.conf
	fi
else
	if ! ls *.fq *.fastq *.fq.gz *.fastq.gz &>>/dev/null;then
		echo -e "\033[031mERROR: Please add your fastq file, or add FNA_FQ.conf.\033[0m"
		exit 1
	fi
fi
