#!/bin/bash


#SBATCH --job-name=HiFiAdaptFiltEcoli
#SBATCH --mem=64G
#SBATCH --cpus-per-task=4
#SBATCH --ntasks=10
#SBATCH --time=1-12:00:00
module load blast+/2.14.1
module load bamtools/2.5.2

# Set parameters
GENOME_SIZE="5m"

# Loop through all .gz files in the current directory
for file in *.gz; do
    # Extract the base name without the extension for the output directory
    base_name=$(basename "$file" .gz)

    # Run Flye for each assembly in the background
    srun --ntasks=1 --cpus-per-task=4 flye --pacbio-hifi "$file" --out-dir "ecoli_assembly_${base_name}" --genome-size 5m --asm-coverage 50 --threads 4 &
done

wait # Wait for all background jobs to finish
