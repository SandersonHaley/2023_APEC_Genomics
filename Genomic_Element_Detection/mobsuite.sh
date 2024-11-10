#!/bin/bash
cat isolatenames.txt | while read line; do  
mob_recon -t --infile "$line"_assembly_complete.fasta -t --outdir "$line"_mobsuiteUNI_3 -n 4 
done
