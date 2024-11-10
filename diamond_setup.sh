#!/bin/bash

cat plasmids.txt |while read line; do

echo "$line"
	sbatch diamond.sh $line

done
