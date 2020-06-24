#!/usr/bin/env bash
set -ue
ISIGNORE=false
cd "$(readlink -f "$(dirname "${0}")"/../)"
. exec/libisopt.sh
for opt in "${@}"; do
	if isopt "${opt}"; then
		case "${opt}" in
		"-h" | "--help")
			echo "Help should be added here."
			exit 0
			;;
		"-v" | "--version")
			echo "BioXP configure version 0"
			exit 0
			;;
		"-f"|"--force")
			bash ../bioxp distclean -f
			;;
		"-i"|"--ignore")
			ISIGNORE=true
			;;
		esac
	fi
done
if { ! ${ISIGNORE};} && { ls *.bioxp &>>/dev/null || [ -f "start.sh" ] || [ -f "wagons.conf" ]; }; then
	echo -e "\033[031mERROR: Directory not clear.
	Please execute 'bioxp distclean' to remove old files if you want to start a new experiment;
	Or, re-execute with additional option '-f|--force' to perform 'bioxp distclean' automatically;
	Or, re-execute with additional option '-i|--ignore' to continue.\033[0m"
	exit 1
fi
if ! [ -f "wagons.conf" ]; then
	echo -e "\033[031mERROR: wagons.conf not found.\033[0m"
	exit 1
fi
cat wagons.conf | grep -v '^#' | while read line; do
	cp -r .wagons/"${line}".bioxp .
done
echo -e "\033[033mInit finished, please add the files to each step and execute 'bioxp reconfigure' to generate all configuration files.\033[0m"
