#!/bin/bash
#SBATCH --account=hpc_p_white
#SBATCH --constraint=skylake
#SBATCH --time=21-00:00:00
#SBATCH --mem=64G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

module load StdEnv/2020
module load cd-hit/4.8.1
source $HOME/panaroo/bin/activate 
mkdir G_Panaroo
panaroo -i *.gff -o G_Panaroo --clean-mode strict -t 4
