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
cp exec/__start.sh start.sh
python .wagons/bioxp_configure.py ignore
