#!/bin/bash
cat Ecoli_Set2_List.txt | while read line; do 
echo "$line"

NanoStat -o "$line"/nanostat_results_rawreads -p "$line" -n "$line"_nanostat_results --fastq "$line"/"$line"_LR_ALL.fastq.gz

done
