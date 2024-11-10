#!/bin/bash
#SBATCH --account=hpc_p_white
#SBATCH --constraint=skylake
#SBATCH --time=21-00:00:00
#SBATCH --mem=64G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

module purge
module load gcc/9.3.0 blast+/2.12.0 python/2.7.18
source $HOME/neptune-env/bin/activate

neptune --inclusion Inclusion_D --exclusion Exclusion_CE --output Inclusion_D_results
neptune --inclusion Inclusion_C --exclusion Exclusion_DE --output Inclusion_C_results
neptune --inclusion Inclusion_E --exclusion Exclusion_CD --output Inclusion_E_results
