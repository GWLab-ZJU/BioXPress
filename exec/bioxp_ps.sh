#!/usr/bin/env bash
set -ue
DN="$(readlink -f "$(dirname "${0}")")"
. "${DN}"/libisopt.sh
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
	fi
done
echo -e "\e[033mPS -- Passenger Searcher\e[0m"
if [ -d "${1}".bioxp ]; then
	echo -e "\e[033mSliding into wagon ${1}...\e[0m"
	# $1 is a wagon.
	cd "${1}".bioxp

	cd ..
else
	for fn in *.bioxp; do
		bash bioxp ps "${fn:0:-6}"
	done
fi
