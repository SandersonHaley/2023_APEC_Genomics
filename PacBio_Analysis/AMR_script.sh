#!/bin/bash
module load StdEnv/2020
module load gcc/9.3.0
module load amrfinderplus
module load abricate/1.0.0

for file in ./assemblies/*.fasta; do
    base_name = $(basename "$file" .fasta)

    amrfinder -n "$file" --ident_min 0.9 --coverage_min 0.5 -o ./AMRFinder/${base_name}.out
    abricate  --db vfdb --minid 80 --mincov 80 "$file" > ./VF/"${basename}.tab"
done
