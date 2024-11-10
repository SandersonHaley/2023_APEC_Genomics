#!/usr/bin/env bash 
cat ecolilist.txt|while read line; do
quast.py "$line"_assembly_complete.fasta -o "$line"_quast_output
done
