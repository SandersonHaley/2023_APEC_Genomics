#!/bin/bash
#SBATCH --account=hpc_p_white
#SBATCH --constraint=skylake
#SBATCH --time=4-00:00:00
#SBATCH --mem=64G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

module load StdEnv/2020
module load cd-hit/4.8.1
source $HOME/panaroo/bin/activate 

# Read cluster names from the outbreak_list.txt file
while IFS= read -r outbreak; do
    echo "Processing outbreak: $outbreak"
    
    # Create a directory for Panaroo output
    mkdir "${outbreak}_Panaroo"

    # Run Panaroo
    panaroo -i "${outbreak}"/*.gff -o "${outbreak}_Panaroo" --clean-mode strict -t 4
    
    echo "Finished processing outbreak: $outbreak"
done < outbreak_list.txt
