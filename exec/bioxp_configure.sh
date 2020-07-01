#!/usr/bin/env bash
set -ue
echo -e "\e[033mconfig -- Configure all/specific wagon(s)\e[0m"
cd "$(readlink -f "$(dirname "${0}")"/../)"
. exec/__libisopt.sh
STDS=()
ARGV="force"
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
        "-i"|"--ignore")
        	ARGV="ignore"
        	echo -e "\e[033mWill pass 'ignore' argument to each configure.sh\e[0m"
        	;;
        esac
    else
    	STDS=("${STDS[@]}" "${opt}")
    fi
done
if [ ${#STDS[@]} -eq 0 ];then
	echo -e "\e[033mWill configure all wagons and check dependencies\e[0m"
	cp exec/__bioxp_start.sh exec/bioxp_start.sh
	python .wagons/bioxp_configure.py "${ARGV}"
else
	for item in "${STDS[@]}";do
		if [ -e "${item}".bioxp ];then
			bash "${item}".bioxp/exec/configure.sh "${ARGV}"
		else
			echo -e "\e[031mERROR: Wagon ${item} not found\e[0m"
		fi
	done
	echo -e "\e[033mFinished. Use 'bioxp start' to start\e[0m"
fi
