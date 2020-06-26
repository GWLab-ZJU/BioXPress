#!/usr/bin/env bash
set -ue
echo -e "\033[033mlistwagons -- Listing all bioxp wagons\033[0m"
cd "$(readlink -f "$(dirname "${0}")"/../)"
. exec/__libisopt.sh
ARGV=""
for opt in "${@}"; do
	if isopt "${opt}"; then
		case "${opt}" in
		"-h" | "--help")
			echo "Help should be added here."
			exit 0
			;;
		"-v" | "--version")
			echo "BioXP listwagons version 0"
			exit 0
			;;
		"-u" | "--upgradable")
			ARGV="diffinstalled"
			echo -e "\e[033mFetching git submodules...\e[0m"
			git submodule update --init --recursive --remote
			;;
		"-d" | "--fulldiff")
			ARGV="fulldiff"
			echo -e "\e[033mFetching git submodules...\e[0m"
			git submodule update --init --recursive --remote
			;;
		"-n" | "--notinstalled")
			ARGV="notinstalled"
			echo -e "\e[033mFetching git submodules...\e[0m"
			git submodule update --init --recursive --remote
			;;
		esac
	fi
done
echo -e "\e[033mLoading local wagons...\e[0m"
python .wagons/readwagons.py &>>/dev/null
echo -e "\e[033mLoading remote wagons...\e[0m"
cd .wagons
python readwagons.py &>>/dev/null
rm -f .bindep .filedep
cd ..
python exec/__bioxp_version_diff.py "${ARGV}"
echo -e "\033[033mFinished\033[0m"
