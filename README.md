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
This folder contains the scripts for the majority of the data analysis for this work. The majority of genonic element detection was done using the ARETE pipeline and the analysis specific to the results to this pre-made pipeline are included in the subfolder *ARETE_Analysis*. The remaining scripts in this folder were used seperate from the ARETE pipeline during different stages of the analysis and to detect or characterize things that are not included in the ARETE pipeline.
### Analysis in the Main Folder
The scripts in this folder include the once for running mob-suite seperate from ARETE (*mobsuite.sh*)and culminating the results (*mobsuite_set_1.ipynb*). The *mappingreads.sh* is used to map the Illumina reads back to the hybrid assemblies. \
\
There are scripts for additional analysis of plasmid contigs from mob-suite, including running prokka (*plasmid_prokka.sh*) and CARD/RGI plasmid_prokka.sh on the plasmid contigs. \
\
The genomes were also characterized based on colicin and genomic island presence. Colicins were detected by using *in silico* primers for each type of colicin in Geneious and the results were analysed for plasmids in *05012023_Colicin_plasmid_results.ipynb* and for genomes  in *05042023_Colicin_genome_results.ipynb*. The analysis of the colicin results used the following python libraries: pandas, numpy, statsmodels, scikit_posthocs, itertools, statannotations, matplotlib, seaborn. \
\
Genomic islands were detected in the genomes using IslandCompare online then culminated using *07052023_Islandcompare_Processing_Heatmap.ipynb* and the presence of genomic islands throughout the phylogenetic tree was analysed using the following python libraries: pandas, numpy, matplotlib, seaborn, networkx, ete3, dendropy, scipy and plotly.
### ARETE Analysis SubFolder
This subfolder consists of the scripts used to analysis the ARETE results. The results of the genomic element characterization steps where combined to create a table with the results for all the genomes analyzed in the following Jupyter Notebooks: "*02072023_EcoliARETE_mobsuite_culmination.ipynb*", "*02142023_EcoliARETE_BACMET_culminate.ipynb*", "*02142023_EcoliARETE_VFDB_culmination.ipynb*" and "*06302023_Culminating_data_ARETE_run2_bacmet_iceberg_islandpath_phispy.ipynb*". The python libraries used are pandas and pathlib for these notebooks. These script also include the filtering of results based on percentage identity. \
\
The Jupyter Notebook *02282023_EcoliARETE_plasmids_heirarchal_clustering.ipynb* used the following python libraries: pandas, seaborn, matplotlib, numpy, fastcluster. A cluster heatmap was made with the phylogenetic tree with the outbreak and sample source annotated with and without heirarchal clustering on the genomes. Seperate heatmaps were made for each sample source (cecal, diseased, environmental and both cecal and diseased). \
\
The Jupyter Notebook *03062023_EcoliARETE_totalfeaturesvsphylogroup.ipynb* used the following python libraries:pandas, numpy, statsmodels, scikit_posthocs, seaboorn, itertools, statannotations and matplotlib. The total amount of different genomic elements was compared between phylogroups. The same librarier were used in *03062023_EcoliARETE_totalfeaturesvssource.ipynb* and *03062023_EcoliARETE_totalfeaturevsoutbreak.ipynb* to compare the total number of each type of genomic element between sources and outbreaks. \
\
In Jupyter Notebook *03072023_EcoliARETE_ANOVA.ipynb*, the following Python libraries were used: pandas, numpy, statsmodels, scikit_posthocs and seaborn. ANOVA was used to determine is the difference between the number of different categories of genomic elements based on source, outbreak and phylogroups was significant and generate draft plots to show these differences. \
\
In *03092023_EcoliARETE_Basic_Stats.ipynb*, the pandas Python library were used to generate basic statistics like how many genomes represented each source, phylogroup and outbreak as well as basic statistics retrieved from the describe function. In *04202023_EcoliARETE_feature_basic_stats.ipynb*, the same basic stats were done for the genomic elements detected. Pie charts representing the different types of antimicrobial resistance (by function and drug class) were made using the seaborn, matplotlib and numpy Python libraries.\
\
In *03092023_EcoliARETE_plasmiddiagram.ipynb*, the following Python libraries were used: pandas, numpy, statsmodels, scikit_posthocs, itertools, statannotations, matplotlib and seaborn. This notebook was used to generate bar plots that represent the different categories of plasmid based on predicted plasmids and mob-suite predicted host ranges.\
\

In *04212023_Refseq_host_range.ipynb*, the following python libraries were used: pandas, numpy, matplotlib, and seaborn. The refseq results to determine additonal more accurate hosts of the plamsids were culminated and a bar graph was made to view the distribution of the plasmids in the different hosts. \
\
In *05012023_AMR_stats_Drug_Class_vs_Source.ipynb*, the following Python libraries were used: pandas, numpy, statsmodels, scikit_posthocs, itertools, statannotations, matplotlib and seaborn. All genomes resistance to each drug classes were compared using an independent T-test and the results are illustrated in graphs. \
\
In *07052023_newBACMET_GI_phage_data_analysis.ipynb*, a newer run of ARETE containing more elements to be detected including a refined BACMET search, and searches for Genomic Islands (total number) and phage were analyzed using the following Python libraries: pandas, numpy, statsmodels, scikit_posthocs, itertools, statannotations, matplotlib and seaborn. The total number of these genomic elements were compared across phylogroup, source and outbreak using independent t-test and this was illustrated in graphs. \
\
In *VIrulence factor Categories.ipynb*, the following Python libraries were used: pandas, re, seaborn and matplotlib. The distribution of virulence factors in different categories was determined and it was illustrated in a pie chart. \
\

## Refseq_Plasmid_Host_Range
This folder contains the scripts  (*diamond.sh* and *diamond_setup.sh*) required to get a more detailed host range of plasmids detected using MOB-suite. It uses the fasta files of the plasmid sequences, the refseq databases and diamond. 
## Extracting_Genes_Genbank
The two Python scripts in this folder (*extractgenesfromgenbackProtein.py* and *extractgenesfromgenbankDNA.py*) do similar things and extract sequences (either DNA or protein) from genbank genome files based on the annotations using the puthon libraries: arparse and Bio.
## Phylogenetic_Analysis
This folder contains the scripts related to the phylogenetic analysis of the genomes. The core genome alignment used to make the phylogenetic tree containing all the genomes was made as part of the ARETE pipeline and scripts for generating the phylogentic tree using iqtree (core_tree_building.sh) and fasttree (fasttree.sh) are included here. The fasttree phylogentic tree was used for downstream analysis. Additional Panaroo runs to generate alignments and trees was done for outbreaks detected (work done by collaborator and used *Outbreak_Panaroo.sh* to make alignments), groups of genomes with similar gene element characteristics (panarooclsuter.sh), and phylogroups (used scripts in the subfolder *Phylogroup* with the following organization [Phylogroup]wO (phylogroup genomes with outgroup), [Phylogroup]noO (phylogroup with no outgroup, and [Phylogroup]_tree.sh (generating phylogenetic trees from the alignments generated by Panaroo using Fasttree). \
\
Neptune (*neptune.sh*)was also used to compare the group of genomes with the same phylogroups to see which genes may be present in one group but not in any of the other identified groups.
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
- IQtree
- Fasttree
- Neptune

## Python Libraries
- pandas
- pathlib
- argparse
- Bio
- requests
- numpy
- matplotlib
- seaborn
- networkx
- ete3
- dendropy
- scipy
- plotly
- statsmodels
- scikit_posthocs
- itertools
- statannotations
- fastcluster

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
