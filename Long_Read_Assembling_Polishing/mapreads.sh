#!/bin/bash 
name=$1

circlator mapreads "$name"_assembly_complete.fasta /home/haley/Desktop/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_*.fq.gz complete_assembly.bam
