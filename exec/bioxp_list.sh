#!/usr/bin/env bash
set -ue
echo -e "\e[033mlist -- Listing all bioxp commands\e[0m"
cd "$(readlink -f "$(dirname "${0}")")"
. __libisopt.sh
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
ls -1 |grep 'bioxp_.*\.sh'|sed -s 's;^bioxp_;;'|sed -s 's;\.sh$;;'
echo -e "\e[033mFinished\e[0m"
