#!/usr/bin/env bash
set -ue
id="${1}"
echo ${$}>reg/"${id##*/}".doing
ascp -QT -l 300m -P33001 -i asperaweb_id_dsa.openssh era-fasp@${1} .&>>reg/"${id##*/}".doing
mv reg/"${id##*/}".doing reg/"${id##*/}".done
