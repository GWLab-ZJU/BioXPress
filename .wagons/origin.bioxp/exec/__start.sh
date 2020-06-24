#!/usr/bin/env bash
set -ue
if [ -e "ENA_FQ.conf" ];then
	cat ../cases.conf | grep -v '^#' | cut -f 1 -d " " | while read line; do
		cat ENA_FQ.conf|grep -v '^#' |grep '.*'"${line}"'_[12].*'| while read id;do
			if ! ls reg/"${id##*/}".*&>>/dev/null;then
				bash exec/dload.sh '${id}'
			fi
		done
	done
fi
