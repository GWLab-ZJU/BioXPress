#!/usr/bin/env bash
set -ue
cd "$(readlink -f "$(dirname "${0}")")"
. ../exec/__liblsf.sh
if [ -e ../etc/adapters.conf ] && [ ! -e ../etc/adapters.conf.tsv ];then
	cat ../etc/adapters.conf|tr '=' '\t'>../etc/adapters.conf.tsv
fi
josys='bash'
cat ../etc/jobsys.conf|grep -v '^#'|while read line;do
	josys="${line}"
done
if [ "${jobsys}" = "bash" ];then
	ALL_JOBS=()
	cat ../all_conf|cut -f 1 -d " "|grep -v \#|while read line;do
		echo ${line}
		for fn in "/${line}_1" "${line}_2";do
			tmpsh="$(mktemp -t 'js.XXXXXX.sh')"
			cat ../exec/__bash_head.sh exec/lsf.sh|\
			sed "s;^WDIR=.*;WDIR=\"$(echo ${PWD})\";"|\
			sed "s;^line=.*;line=\"$(echo ${fn})\";">"${tmpsh}"
			ALL_JOBS=("${ALL_JOBS[@]}" "$(bash "${tmpsh}" & ; echo ${!})")
			rm "${tmpsh}"
		done
	done
	for job in "${ALL_JOBS[@]}";do
		wait "${job}"
	done
elif [ "${jobsys}" = "bjobs" ];then
	ALL_JOBS=()
	cat ../all_conf|cut -f 1 -d " "|grep -v \#|while read line;do
		echo ${line}
		for fn in "/${line}_1" "${line}_2";do
			tmpsh="$(mktemp -t 'js.XXXXXX.sh')"
			cat ../exec/__lsf_head.sh exec/lsf.sh|\
			sed "s;^WDIR=.*;WDIR=\"$(echo ${PWD})\";"|\
			sed "s;^line=.*;line=\"$(echo ${fn})\";"|\
			sed "s;\# BSUB -o;\# BSUB -o lsf_$(echo ${fn})_$(date +%Y-%m-%d_%H-%M).log;">"${tmpsh}"
			tmpjb="$(cat "${tmpsh}"|lsfbash)"
			echo ${$} >reg/"${fn}".doing
			ALL_JOBS=("${ALL_JOBS[@]}" "${tmpjb}")
			rm "${tmpsh}"
		done
	done
	for job in "${ALL_JOBS[@]}";do
		waitlsf "${job}"
	done
fi
echo -e "\e[033mFinished. Please execute 'start_web_server.sh' to see the results.\e[0m"
