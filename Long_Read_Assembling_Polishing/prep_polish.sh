#!/bin/bash
cat unassembledlistEfaecalis.txt| while read line; do  
	echo "Submitting job for file $line"
	mkdir "$line"_longreadpolishing/"$line"_polishing
	cp polishing_template_adapted.sh "$line"_longreadpolishing/"$line"_polishing/
	cd "$line"_longreadpolishing/"$line"_polishing
	sbatch  -p ExternalResearch -c 1 --mem=20G --ntasks=15 --time=0 polishing_template_adapted.sh "$line"
        cd ..
        cd ..
done
