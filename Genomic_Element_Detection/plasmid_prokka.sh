#!/bin/bash

find . -maxdepth 6 -name "*plasmid*" -exec sh -c 'x="{}"; cut -d '_' -f1 ${x} > ${x}_trimmed' \;

find . -maxdepth 6 -name "*plasmid*trimmed" -exec sh -c 'x="{}"; prokka ${x} --outdir plasmid_prokka_files/${x}' \;
 
