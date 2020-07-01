#!/usr/bin/env bash
set -ue
shopt -s expand_aliases
cd "$(readlink -f "$(dirname "${0}")")"
. ../exec/__libdo.sh
LIBDO_LOG="ascp_$(date +%Y-%m-%d_%H-%M).log"
if ! [ -e next.sh ]; then
	echo -e "\e[031mERROR: next.sh do not exist!\e[0m"
	exit 1
fi
bash next.sh
if [ -e "ENA_FQ.conf" ]; then
	cat ../etc/cases.conf | grep -v '^#' | cut -f 1 -d " " | while read line; do
		cat ENA_FQ.conf | grep -v '^#' | grep '.*'"${line}"'_[12].*' | while read id; do
			fn="${id##*/}"
			if ! ls reg/"${fn}".* &>>/dev/null; then
				DO ascp -QT -l 300m -P33001 -i asperaweb_id_dsa.openssh era-fasp@${id} . &
				DOPID=${!}
				echo ${DOPID} >reg/"${fn}".doing
				wait ${DOPID}
				if ! [ -f "${fn}" ]; then
					echo -e "\e[031mERROR: Failed to download ${fn}\e[0m"
					exit 1
				fi
				fn_fq="$(echo "${fn}" | sed 's;\.fastq;\.fq;')"
				if [[ "${fn}" =~ .*\.fastq.* ]]; then
					mv "${fn}" "${fn_fq}"
				fi
				if [[ "${fn_fq}" =~ .*\.fq ]]; then
					gzip -1 "${fn_fq}"
				fi
				mv reg/"${fn}".doing reg/"${fn}".done
			else
				echo -e "\e[031mWARNING: Lock file exists for ${line}\e[0m"
				if ! [ -f "${fn}" ]; then
					echo -e "\e[031mERROR: Failed to download ${fn}.\e[0m"
					exit 1
				fi
			fi
		done
	done
fi
