#!/usr/bin/env bash
set -ue
cd "$(readlink -f "$(dirname "${0}")")"
. libisopt.sh
for opt in "${@}"; do
    if isopt "${opt}"; then
        case "${opt}" in
        "-h" | "--help")
            echo "Help should be added here."
            exit 0
            ;;
        "-v" | "--version")
        	echo "BioXP list version 0"
        	exit 0
            ;;
        esac
    fi
done
echo -e "\033[033mListing all bioxp commands...\033[0m"
ls -1 |grep 'bioxp_.*\.sh'|sed -s 's;^bioxp_;;'|sed -s 's;\.sh$;;'
