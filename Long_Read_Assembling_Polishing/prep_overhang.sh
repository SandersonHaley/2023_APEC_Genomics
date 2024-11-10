#!/bin/bash
cat overhanglist.txt| while read line; do  
	echo "Submitting job for file $line"
	cp  fixstart_genomes.sh "$line"_longreadpolishing/"$line"_polishing
	cd "$line"_longreadpolishing/"$line"_polishing
	sh  fixstart_genomes.sh "$line"
        cd ..
        cd ..
done
