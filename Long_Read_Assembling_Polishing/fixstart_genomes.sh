#!/bin/bash 
name=$1

circlator fixstart --genes_fa /home/haley/Desktop/Unassembled_polishing/dnaa_sequences.nucleotides.fa "$name"_assembly2_no_overhang.circularise.fasta assembly_complete
