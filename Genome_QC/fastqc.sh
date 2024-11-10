cat ecoliset2.txt |while read line; do
	echo "$line"
	fastqc "$line"/"$line"_*.fq.gz
done
