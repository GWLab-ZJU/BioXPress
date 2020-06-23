#!/usr/bin/env bash
set -ue
echo -e "\e[31mConfiguring original...\e[0m"
if [ -f "origin.conf" ];then
	rm "origin.conf"
fi
echo '#!/usr/bin/env bash
set -ue'>start.sh
echo -e "\e[31mWhere the data come from? Select a number.
1. Online database -- We'll use 'ascp' to download FASTQ data from ENA database.
2[DEFAULT]. We'll upload our files on our own.\e[0m"
read -p "1/2>" ANS
if [ "${ANS}" = "1" ];then
	echo -e "Please configure ENA_FQ.conf later."
	echo 'ENA_FQ=True'>start.sh
else
	echo 'ENA_FQ=False'>start.sh
fi
cat exec/__start.sh >>start.sh
