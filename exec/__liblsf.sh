function waitlsf() {
	if [ $(bjobs ${1} | wc -l | cut -f 1 -d ' ') -eq 1 ]; then
		return 1
	fi
	while true; do
		sleep 1
		if [ "$(bjobs ${1} | awk 'BEGIN  { FIELDWIDTHS = "8 8 4" };{print $3;}' | tail -n 1)" = "DONE" ]; then
			return
		fi
	done
}
function lsfbash() {
	tmpsh="$(mktemp -t 'lsfbash.XXXXXX')"
	while read line;do
		echo "${line}">"${tmpsh}"
	done
	cat "${tmpsh}" | bsub | sed 's/.*<\([0-9]*\)>.*/\1/'
}
