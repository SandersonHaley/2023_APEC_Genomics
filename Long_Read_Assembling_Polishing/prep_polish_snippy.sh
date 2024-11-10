!/bin/bash
cat unassembledlistsnippy.txt| while read line; do  
	echo "Submitting job for file $line"
	mkdir "$line"_longreadpolishing/"$line"_polishing
	cp polishing_template_adapted_snippy.sh "$line"_longreadpolishing/"$line"_polishing/
	cd "$line"_longreadpolishing/"$line"_polishing
	sbatch  -p ExternalResearch -c 8 --mem=64G --ntasks=15 --time=0 polishing_template_adapted_snippy.sh "$line"
        cd ..
        cd ..
done
