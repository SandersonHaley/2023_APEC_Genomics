#!/bin/bash
cat overhanglist.txt| while read line; do  
	echo "Submitting job for file $line"
	cp  mapreads.sh "$line"_longreadpolishing/"$line"_polishing
	cd "$line"_longreadpolishing/"$line"_polishing
	sh  mapreads.sh "$line"
        cd ..
        cd ..
done
