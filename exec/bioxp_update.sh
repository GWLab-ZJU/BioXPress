#!/usr/bin/env bash
set -ue
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
        esac
    fi
done
echo -e "\e[033mFetching git submodules...\e[0m"
git submodule update --init --recursive --remote
echo -e "\e[033mLoading local wagons...\e[0m"
python .wagons/readwagons.py &>> /dev/null
echo -e "\e[033mLoading remote wagons...\e[0m"
cd .wagons
python readwagons.py &>> /dev/null
cd ..
python exec/__bioxp_version_diff.py
