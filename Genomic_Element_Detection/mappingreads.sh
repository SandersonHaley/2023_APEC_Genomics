#!/usr/bin/env bash 
cat Ecolilistmapping.txt|while read line; do
bwa index "$line"_assembly_complete.fasta
bwa mem -v 2 -M -t 15 "$line"_assembly_complete.fasta /media/haley/Expansion/Ecoli/Ecoli_Hybrid_Assembly_Sets/Ecoli_Hybrid_Waffles/"$line"_hybrid/"$line"_SR_1.fq.gz /media/haley/Expansion/Ecoli/Ecoli_Hybrid_Assembly_Sets/Ecoli_Hybrid_Waffles/"$line"_hybrid/"$line"_SR_2.fq.gz|
samtools view -u -T "$line"_assembly_complete.fasta -F 3844 -q 60 | samtools sort --reference "$line"_assembly_complete.fasta >> "$line"_illumina_mapped.bam
done
