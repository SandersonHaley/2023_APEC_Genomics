# 2023_APEC_Genomics
This repo contains all of the scripts for data processing and analysis for the APEC genomics manuscript.
# Workflow
## Hybrid_Genome_Assembly
This folder has the scripts required to do hybrid bacteria (E.coli) assemblies using Illumina and Nanopore reads. The *hybridassemblywaffles.sh* includes the workflow for hibrid assembly from raw reads to complete assemblies and the *prep-hybrid-assembly.sh* allows you to repeat the assembly scripts on slurm for all the read sets for the genomes you are assembling.
Steps in the **hybridassemblywaffles.sh* script: \
1. Assess the quality of the Nanopore long reads with Nanostat.
2. Trim the adaptors from the Nanopore Long reads with porechop.
3. Filter out bad reads and long reads below a certain length with filtlong.
4. Get new quality of the remaining trimmed reads used for long read assembly using Nanostat.
5. Assemble the trimmed and filtered Nanopore long reads using Flye.
6. Get quality of long read assembly with Quast.
7. Trim and remove adapters from Illumina short reads using fastp.
8. Hybrid assembly using unicycler with the long read assembly (as trusted contigs) and the trimmed short reads.
9. Get quality of the hybrid assembly using Quast.
10. Polish hybrid assembly with raw short reads using Pilon 12 times. Most assembles will no longer have SNPS after this step.
11. Most assemblies will contain no SNPs after the first 12 rounds of pilon. If there still is SNPs then additional polishing with SNIPPY.
12. Additional 15 steps of pilon polishing is required after snippy to remove the remaining SNPs.
13. Map the short reads to the assembly using bwa and samtools.
14. Get quality of the polished assembly using Quast.
## Long_Read_Assembling_Polishing
This folder includes scripts used to assemble genomes that did not sucessfully assemble using the scripts in *Hybrid_Genome_Assembly*. In some cases, a similar process was used but spades was substituted for Unicycler, in script *spades_commands.sh*. In other cases the long read assemblies were generated with Flye then polished with the Illumina short reads using the scripts: *prep_polish.sh*, *prep_polish_snippy.sh*, *polish_template_adapted.sh*, and *polish_template_adapted_snippy.sh*. \
\
Additional processing was done on all genomes using the following scripts:
- Mapping short reads to the completed assemblies using *prep_mapreads.sh* and *mapreads.sh* using bwa and samtools.
- Circularise and remove overhangs from the assemblies using *prep_overhang.sh* and *overhang_removal.sh* which uses circlator.
- Fix the starting point for each genome using *prep_fixstart.sh* and *fixstart_genomes.sh* which uses circulator.
## Genome_QC
During the process of making the workflows in *Hybrid_Genome_Assembly* and *Long_Read_Assembling_Polishing*. The quality of genomes was checked continuously using quast, nanostat and fastqc. The shell scripts (*nanostat.sh*, *quast.sh*, and *fastqc.sh*) show how to run these programs seperately on the genomes. The Jupyter Notebooks (*EcoliSet2_Quast.ipynb*, *Ecoli_Set1_quast.ipynb*, *nanostat_set_2.ipynb*) show how these results were gathered together in one csv file using the python libraries: pandas and pathlib.
## Genomic_Element_Detection
## Refseq_Plasmid_Host_Range
This folder contains the scripts  (*diamond.sh* and *diamond_setup.sh*) required to get a more detailed host range of plasmids detected using MOB-suite. It uses the fasta files of the plasmid sequences, the refseq databases and diamond. 
## Extracting_Genes_Genbank
The two Python scripts in this folder (*extractgenesfromgenbackProtein.py* and *extractgenesfromgenbankDNA.py*) do similar things and extract sequences (either DNA or protein) from genbank genome files based on the annotations using the puthon libraries: arparse and Bio.
## Phylogenetic_Analysis
## EvolCCM_Network_Analysis
Co-evolutionary analysis was done using EvolCCM and this was used to create networks showing the colocation/cotransfer of different genes from a co-ecvolutionary standpoint. The running of EvolCCM was done by a collaborator and these scripts are just used to filter the results (09122023_evolccm_convert_table.ipynb) using pandas and generate the networks from the results (networks.py) using the python libraries: argparse, requests and pandas.This analysis was subsequently removed from the final analysis of the genomes.
	
# Software
## Stand-alone Programs
- Nanostat
- Porechop
- Filtlong
- Flye
- Quast
- Fastp
- Unicycler
- bwa
- samtools
- pilon
- nucmer
- snippy
- bgzip
- tabix
- vcftools
- circulator
- diamond

## Python Libraries
- pandas
- pathlib
- argparse
- Bio
- requests

# Author
**Main Contributor** \
Dr. Haley Sanderson \
Bioinformatics Programmer \
Agriculture and Agri-Food Canada \
Haley Sanderson Consulting \
haley.sanderson@agr.gc.ca or haley.sanderson.092018@gmail.com
# License
Please view the licence [here](LICENSE)
# Notes
# References
