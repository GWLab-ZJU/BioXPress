#!/usr/bin/env bash
set -ue
echo -e "\e[033mPS -- BioXPress Passenger Searcher\e[0m"
DN="$(readlink -f "$(dirname "${0}")")"
. "${DN}"/__libisopt.sh
STDS=()
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
		esac
	else
		STDS=("${STDS[@]}" "${opt}")
	fi
done
if [[ "${PWD}" =~ .+".bioxp" ]];then
	echo -e "\e[033mSliding into wagon ${PWD}...\e[0m"
	python "${DN}"/__bioxp_ps_sub.py
elif [ ${#STDS[@]} -eq 0 ]; then
	cd "${DN}"/..
	for dir in *.bioxp; do
		echo -e "\e[033mSliding into wagon ${dir}...\e[0m"
		cd "${dir}"
		python "${DN}"/__bioxp_ps_sub.py
		cd ..
	done
else
	cd "${DN}"/..
	for dir in "${STDS[@]}"; do
		if [ -d "${dir}".bioxp ]; then
			echo -e "\e[033mSliding into wagon ${dir}...\e[0m"
			cd "${dir}".bioxp
			python "${DN}"/__bioxp_ps_sub.py
			cd ..
		fi
	done
fi
echo -e "\033[033mFinished\033[0m"
