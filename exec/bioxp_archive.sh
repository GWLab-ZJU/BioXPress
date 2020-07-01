#!/usr/bin/env bash
set -ue
echo -e "\e[033marchive -- Archive a wagon for next group of further use\e[0m"
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
if [[ "${PWD}" =~ .+".bioxp" ]]; then
	echo -e "\e[033mSliding into wagon ${PWD}...\e[0m"
	if [ -f "archive.sh" ]; then
		bash archive.sh
	else
		echo -e "\e[031mERROR: No archive.sh! You need to hire a porter for this wagon.\e[0m"
		exit 1
	fi
elif [ ${#STDS[@]} -eq 0 ]; then
	cd "${DN}"/..
	for dir in *.bioxp; do
		echo -e "\e[033mSliding into wagon ${dir}...\e[0m"
		cd "${dir}"
		if [ -f "archive.sh" ]; then
			bash archive.sh
		else
			echo -e "\e[031mERROR: No archive.sh! You need to hire a porter for this wagon.\e[0m"
			exit 1
		fi
		cd ..
	done
else
	cd "${DN}"/..
	for dir in "${STDS[@]}"; do
		if [ -d "${dir}".bioxp ]; then
			echo -e "\e[033mSliding into wagon ${dir}...\e[0m"
			cd "${dir}".bioxp
			if [ -f "archive.sh" ]; then
				bash archive.sh
			else
				echo -e "\e[031mERROR: No archive.sh! You need to hire a porter for this wagon.\e[0m"
				exit 1
			fi
			cd ..
		fi
	done
fi
echo -e "\e[033mFinished\e[0m"
