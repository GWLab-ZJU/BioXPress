#!/usr/bin/env bash
set -ue
echo -e "\e[033minit -- Initializing BioXPress by adding wagons, or add wagons to an existing train\e[0m"
ISIGNORE=false
cd "$(readlink -f "$(dirname "${0}")"/../)"
. exec/__libisopt.sh
for opt in "${@}"; do
	if isopt "${opt}"; then
		case "${opt}" in
		"-h" | "--help")
			echo "Help should be added here."
			exit 0
			;;
		"-v" | "--version")
			echo "BioXP init version 0"
			exit 0
			;;
		"-f" | "--force")
			echo -e "\e[033mWill use DISTclean to remove previous wagons.\e[0m"
			bash bioxp distclean -f
			;;
		"-i" | "--ignore")
			ISIGNORE=true
			;;
		esac
	fi
done
mkdir -p etc
touch etc/bin.conf etc/file.conf etc/jobsys.conf
if { ! ${ISIGNORE}; } && { ls *.bioxp &>>/dev/null || [ -f "start.sh" ]; }; then
	echo -e "\e[031mERROR: Directory not clear.
	Please execute 'bioxp distclean' to remove old files if you want to start a new experiment;
	Or, re-execute with additional option '-f|--force' to perform 'bioxp distclean' automatically;
	Or, re-execute with additional option '-i|--ignore' to continue.\e[0m"
	exit 1
fi
if ! [ -f "etc/wagons.conf" ]; then
	echo -e "\e[031mERROR: etc/wagons.conf not found.\e[0m"
	exit 1
fi
if ${ISIGNORE}; then
	cat etc/wagons.conf | grep -v '^#' | while read line; do
		if ! [ -d "${line}".bioxp ]; then
			echo -e "\e[032mAdding wagon ${line} to current train...\e[0m"
			cp -rf .wagons/"${line}".bioxp .
		else
			echo -e "\e[031mWARNING: Wagon ${line} exists in current train!\e[0m"
		fi
	done
else
	cat etc/wagons.conf | grep -v '^#' | while read line; do
		echo -e "\e[032mAdding wagon ${line} to current train...\e[0m"
		rm -rf "${line}".bioxp
		cp -r .wagons/"${line}".bioxp .
	done
fi
python exec/__md2usage.py doc/init.md
python .wagons/bioxp_init.py
echo -e "\e[032mInitialize finished, please configure each step and execute 'bioxp configure' to detect all configuration files.\e[0m"
