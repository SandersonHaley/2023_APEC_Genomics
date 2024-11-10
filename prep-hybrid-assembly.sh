#!/bin/bash

cat ecoliset2.txt |while read line; do

echo "Submitting job for file $line"
	sbatch hybridassemblywaffles.sh "$line"


done
