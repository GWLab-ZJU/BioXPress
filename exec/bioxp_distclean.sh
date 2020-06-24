#!/usr/bin/env bash
set -ue
ISFORCE=false
STDS=()
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
        	echo "BioXP distclean version 0"
        	exit 0
            ;;
        "-f"|"--force")
        	ISFORCE=true
        	;;
        esac
    else
    	STDS=("${STDS[@]}" "${opt}")
    fi
done
echo -e "\e[033mdistclean -- Disattach all wagons and configuration files\e[0m"
if ! ${ISFORCE};then
echo -e "\033[031mWARNING! THIS WILL REMOVE ALL FILES GENERATED IN THIS PROJECT AND CONFIGURATION FILES UNDER ${PWD}! FOR COMMON CLEAN-UP TASKS, PLEASE EXECUTE 'bioxp clean'.\033[0m"
read -p 'Y/N>' ANS
else
	ANS="Y"
fi
if [ "${ANS}" = "Y" ];then
	if [ ${#STDS} -eq 0 ];then
		rm -rf *.bioxp/ start.sh
	elif [ "${STDS[0]}" = '*' ];then
		rm -rf *.bioxp/
	else
		for stdi in "${STDS[@]}";do
			rm -rf "${stdi}".bioxp/
		done
	fi
fi
