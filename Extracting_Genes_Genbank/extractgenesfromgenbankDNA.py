#!/usr/bin/env python

import sys

from Bio import SeqIO

genbank_file = sys.argv[1]
gene_name = sys.argv[2]

records = SeqIO.parse(genbank_file, 'genbank')

for record in records:
    for feature in record.features:
        if feature.type == 'CDS' and gene_name in feature.qualifiers['gene']:
            outfile = gene_name + '_' + genbank_file.replace('.gb', '.fasta')
            with open(outfile, 'w') as outf:
                outf.write('>' + record.name + '_' + gene_name + '\n')
                outf.write(str(feature.extract(record.seq)) + '\n')
