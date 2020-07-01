if  [ -z "${ETCPATH:-}" ];then
	exit 1
fi
if [ -e "${ETCPATH}"/bin.conf ];then
	shopt -s expand_aliases
	tmpsh=$(mktemp libphaseetc.XXXXX)
	cat "${ETCPATH}"/bin.conf|grep -v '^#'|sed -s 's;^;alias ;'>"${tmpsh}"
	. "${tmpsh}"
	rm -f "${tmpsh}"
fi
if [ -e "${ETCPATH}"/file.conf ];then
	. "${ETCPATH}"/file.conf
fi
