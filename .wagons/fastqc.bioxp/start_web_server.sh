#!/usr/bin/env bash
set -ue
cd "$(readlink -f "$(dirname "${0}")")"
rm -f index.html
cat etc/lighttpd.conf|sed 's;server.document-root.*;server.document-root = '"\"$(pwd)\""';'>lighttpd.conf
echo '<html><head><title>FASTQC_SCORES</title></head><body>'>index.html.tmp
if ls *.html&>>/dev/null;then
    for fn in *.html;do
	echo '<p><a href='"\"${fn}\""'>'"${fn}"'</a></p>'>>index.html.tmp
    done
fi
echo '</body></html>'>>index.html.tmp
mv index.html.tmp index.html
lighttpd -D -f lighttpd.conf
rm -f lighttpd.conf
