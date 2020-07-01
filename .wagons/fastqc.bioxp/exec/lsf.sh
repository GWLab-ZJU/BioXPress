ETCPATH="../etc"
. "${ETCPATH}"/__libphaseetc.sh
adapterfn=''
fn="../origin.bioxp/${line}.fq.gz"
if [ -e "${ETCPATH}"/adapters.conf.tsv ]; then
	adapterfn=" -a ${ETCPATH}/adapters.conf.tsv "
fi
if [ -f "${fn}" ] && ! ls reg/"${fn}".* &>>/dev/null; then
	fastqc "${fn}" --outdir ${WDIR} --threads 1 ${adapterfn}
fi
mv reg/"${line}".doing reg/"${line}".done
