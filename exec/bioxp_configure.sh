#!/usr/bin/env bash
set -ue
echo -e "\033[033mconfig -- Configure all/specific wagon(s)\033[0m"
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
        	echo -e "\033[033mWill pass 'ignore' argument to each configure.sh\033[0m"
        	;;
        esac
    else
    	STDS=("${STDS[@]}" "${opt}")
    fi
done
if [ ${#STDS[@]} -eq 0 ];then
	echo -e "\033[033mWill configure all wagons and check dependencies\033[0m"
	cp exec/__start.sh start.sh
	python .wagons/bioxp_configure.py "${ARGV}"
else
	for item in "${STDS[@]}";do
		if [ -e "${item}".bioxp ];then
			bash "${item}".bioxp/configure.sh "${ARGV}"
		else
			echo -e "\033[031mERROR: Wagon ${item} not found\033[0m"
		fi
	done
	echo -e "\033[033mFinished\033[0m"
fi
