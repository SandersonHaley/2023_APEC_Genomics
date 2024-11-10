#!/bin/bash
#SBATCH --account=hpc_p_white
#SBATCH --constraint=skylake
#SBATCH --time=21-00:00:00
#SBATCH --mem=64G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16

plasmid=$1
module load StdEnv/2020
module load diamond/2.1.6
diamond blastx -d refseq_database -q "$plasmid".fasta -o "$plasmid"_matches.tsv --evalue 10-50 --id 90 --subject-cover 90 -f 6 qseqid sseqid pident slen qlen length mismatch gapopen qstart qend sstart send send evalue bitscore

