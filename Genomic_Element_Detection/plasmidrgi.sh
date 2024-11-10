#!/bin/bash

cat plasmids.txt |while read line; do

echo "$line"
	rgi main -i "$line".fasta -o "$line"_rgi_output -t contig -a DIAMOND --include_loose --debug --low_quality -d plasmid 
done
