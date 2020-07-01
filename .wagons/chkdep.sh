#!/usr/bin/env bash
set -ue
cd etc
. file.conf
. bin.conf
cd ..
cat .bindep|grep -v '\#'|while read line;do
	if which "${line:-}" &>>/dev/null;then
		echo -e "\e[032mBinary ${line} found at '$(which ${line})'\e[0m"
	elif which "${!line:-}" &>>/dev/null;then
		echo -e "\e[032mBinary ${line} defined at '$(which ${!line})'\e[0m"
	elif [ -x "${!line:-}" ];then
		echo -e "\e[032mBinary ${line} defined at '${!line}'\e[0m"
	else
		echo -e "\e[031mERROR: Binary ${line} neither present in \$PATH nor defined.\e[0m"
		exit 1
	fi
done
cat .filedep|grep -v '\#'|while read line;do
	if [ -n "${!line:-}" ];then
		echo -e "\e[032mFile ${line} defined at '${!line}'\e[0m"
	else
		echo -e "\e[031mERROR: File ${line} not defined.\e[0m"
		exit 1
	fi
done
