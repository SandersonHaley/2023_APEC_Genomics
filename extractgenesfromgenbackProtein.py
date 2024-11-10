#!/usr/bin/env python

import argparse
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

def parse_args():
    parser = argparse.ArgumentParser(description='Extracts a specific sequence gene from a genbank file and translates it to protein with the output as a .faa file')
    parser.add_argument('-g', '--genbank', help='Input genbank file', required=True)
    parser.add_argument('-n', '--geneName', help='Name of gene to extract', required=True)
    return parser.parse_args()

def main():
    args = parse_args()
    genbank_file = args.genbank
    geneName = args.geneName
    # Create a list of SeqRecord objects from the genbank file
    records = list(SeqIO.parse(genbank_file, "genbank"))
    for record in records: 
        for feature in record.features:
            if feature.type == 'CDS':
                # Find the gene with the specified name
                if 'gene' in feature.qualifiers and feature.qualifiers['gene'][0] == geneName:
                    # Extract the sequence of the gene
                    gene_sequence = feature.extract(record.seq)
                    # Translate the gene sequence to protein
                    protein_sequence = Seq.translate(gene_sequence)
                    # Create a SeqRecord object of the protein sequence
                    protein_record = SeqRecord(protein_sequence, id=geneName)
                    # Save the protein sequence as a .faa file
                    SeqIO.write(protein_record, geneName + '_' + genbank_file + '.faa', 'fasta')

if __name__ == '__main__':
    main()
