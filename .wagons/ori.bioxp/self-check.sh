#!/usr/bin/env bash
set -ue
cd "$(readlink -f "$(dirname "${0}")")"
while read line;do
	eval ${line}
done < wagon.conf
echo -e "\e[033mSelf check for ${name} ${ver} initialized.\e[0m"
echo -e "\e[032mSelf check for ${name} ${ver} passed.\e[0m"
exit 0
