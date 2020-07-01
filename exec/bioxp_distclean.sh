#!/usr/bin/env bash
set -ue
ISFORCE=false
STDS=()
echo -e "\e[033mDISTclean -- Disattach Initialized Speeding Train clean\e[0m"
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
			echo "BioXP distclean version 0"
			exit 0
			;;
		"-f" | "--force")
			ISFORCE=true
			;;
		esac
	else
		STDS=("${STDS[@]}" "${opt}")
	fi
done
if ! ${ISFORCE}; then
	echo -e "\e[031mWARNING! THIS WILL REMOVE ALL FILES GENERATED IN THIS PROJECT AND CONFIGURATION FILES UNDER ${PWD}! FOR COMMON CLEAN-UP TASKS, PLEASE EXECUTE 'bioxp clean'.\e[0m"
	read -p 'Y/N>' ANS
else
	ANS="Y"
fi
if [ "${ANS}" = "Y" ]; then
	if [ ${#STDS[@]} -eq 0 ]; then
		rm -rf *.bioxp/ start.sh
	elif [ "${STDS[0]}" = '*' ]; then
		rm -rf *.bioxp/
	else
		for stdi in "${STDS[@]}"; do
			rm -rf "${stdi}".bioxp/
		done
	fi
fi
echo -e "\e[032mDISTclean Finished\e[0m"
