#!/usr/bin/env bash
echo ${$}>reg/"${id##*/}".wip
ascp -QT -l 300m -P33001 -i asperaweb_id_dsa.openssh era-fasp@${1} .&>>reg/"${id##*/}".wip
mv reg/"${id##*/}".wip reg/"${id##*/}".finished
