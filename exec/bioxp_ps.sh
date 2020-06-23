#!/usr/bin/env bash
set -ue
if [ -d "${1}".bioxp ];then
	# $1 is a wagon.
	""
else
	for fn in *.bioxp;do
		bash bioxp ps "${fn:0:-6}"
	done
fi