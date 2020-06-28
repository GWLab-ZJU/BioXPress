#!/usr/bin/env bash
cd "$(readlink -f "$(dirname "${0}")")"

cat ../all_conf|cut -f 1 -d " "|grep -v \#|while read line;do
    echo ${line}
    cat ../etc/bindep.conf ../etc/filedep.conf ../exec/__lsf_head.sh exec/lsf.sh|\
    sed "s;^WDIR=.*;WDIR=\"$(echo ${PWD})\";"|\
    sed "s;^line=.*;line=\"$(echo ${line})\";"|\
    sed "s;\# BSUB -o;\# BSUB -o lsf_$(echo ${line})_$(date +%Y-%m-%d_%H-%M).log;"|${bsub}
done




cat lighttpd.conf|sed 's;server.document-root.*;server.document-root = '"\"$(pwd)\""';'>lighttpd.conf.tmp
echo '<html><head><title>FASTQC_SCORES</title></head><body>'>index.html.tmp
if ls *.html&>>/dev/null;then
    for fn in *.html;do
	echo '<p><a href='"\"${fn}\""'>'"${fn}"'</a></p>'>>index.html.tmp
    done
fi
echo '</body></html>'>>index.html.tmp
mv index.html.tmp index.html
lighttpd -D -f lighttpd.conf.tmp
rm -f lighttpd.conf.tmp
