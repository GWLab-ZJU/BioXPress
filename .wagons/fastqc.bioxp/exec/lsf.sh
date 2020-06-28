for fn in "../origin.bioxp/${line}_1.fq.gz" "../origin.bioxp/${line}_2.fq.gz";do
    if [ -f "${fn}" ];then
        fastqc "${fn}" --outdir ${WDIR} --threads 1 &>>reg/"${line##*/}".doing
    else
        echo "${fn} not exist!"
    fi
done
