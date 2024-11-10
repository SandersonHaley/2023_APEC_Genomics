#!/bin/bash
#SBATCH --account=hpc_p_white
#SBATCH --constraint=skylake
#SBATCH --time=21-00:00:00
#SBATCH --mem=64G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
module load fasttree-double/2.1.11
FastTree -gtr -gamma -nt C_Panaroo/core_gene_alignment.aln > Ecoli_tree_file_C.treefile
