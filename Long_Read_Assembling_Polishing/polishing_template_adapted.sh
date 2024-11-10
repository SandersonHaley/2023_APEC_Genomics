#!/bin/bash 
name=$1
bwa index ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_LR_assembly.fasta
bwa mem  -v 2 -M -t 15 ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_LR_assembly.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_LR_assembly.fasta -F 3844 -q 60 | samtools sort --reference ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_LR_assembly.fasta> "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_LR_assembly.fasta --frags "$name".pilon.bam --output "$name".pilon.0 

nucmer -p "$name".pilon.0.nucmer ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_LR_assembly.fasta "$name".pilon.0.fasta
show-snps -C -T -r "$name".pilon.0.nucmer.delta > "$name".pilon.0.nucmer.delta.log
bwa index "$name".pilon.0.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.0.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.0.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.0.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.0.fasta --frags "$name".pilon.bam --output "$name".pilon.1 

nucmer -p "$name".pilon.1.nucmer "$name".pilon.0.fasta "$name".pilon.1.fasta
show-snps -C -T -r "$name".pilon.1.nucmer.delta > "$name".pilon.1.nucmer.delta.log
bwa index "$name".pilon.1.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.1.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.1.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.1.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.1.fasta --frags "$name".pilon.bam --output "$name".pilon.2 

nucmer -p "$name".pilon.2.nucmer "$name".pilon.1.fasta "$name".pilon.2.fasta
show-snps -C -T -r "$name".pilon.2.nucmer.delta > "$name".pilon.2.nucmer.delta.log
bwa index "$name".pilon.2.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.2.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.2.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.2.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.2.fasta --frags "$name".pilon.bam --output "$name".pilon.3 

nucmer -p "$name".pilon.3.nucmer "$name".pilon.2.fasta "$name".pilon.3.fasta
show-snps -C -T -r "$name".pilon.3.nucmer.delta > "$name".pilon.3.nucmer.delta.log
bwa index "$name".pilon.3.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.3.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.3.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.3.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.3.fasta --frags "$name".pilon.bam --output "$name".pilon.4 

nucmer -p "$name".pilon.4.nucmer "$name".pilon.3.fasta "$name".pilon.4.fasta
show-snps -C -T -r "$name".pilon.4.nucmer.delta > "$name".pilon.4.nucmer.delta.log
bwa index "$name".pilon.4.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.4.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.4.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.4.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.4.fasta --frags "$name".pilon.bam --output "$name".pilon.5 

nucmer -p "$name".pilon.5.nucmer "$name".pilon.4.fasta "$name".pilon.5.fasta
show-snps -C -T -r "$name".pilon.5.nucmer.delta > "$name".pilon.5.nucmer.delta.log
bwa index "$name".pilon.5.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.5.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.5.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.5.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.5.fasta --frags "$name".pilon.bam --output "$name".pilon.6 

nucmer -p "$name".pilon.6.nucmer "$name".pilon.5.fasta "$name".pilon.6.fasta
show-snps -C -T -r "$name".pilon.6.nucmer.delta > "$name".pilon.6.nucmer.delta.log
bwa index "$name".pilon.6.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.6.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.6.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.6.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.6.fasta --frags "$name".pilon.bam --output "$name".pilon.7 

nucmer -p "$name".pilon.7.nucmer "$name".pilon.6.fasta "$name".pilon.7.fasta
show-snps -C -T -r "$name".pilon.7.nucmer.delta > "$name".pilon.7.nucmer.delta.log
bwa index "$name".pilon.7.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.7.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.7.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.7.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.7.fasta --frags "$name".pilon.bam --output "$name".pilon.8 

nucmer -p "$name".pilon.8.nucmer "$name".pilon.7.fasta "$name".pilon.8.fasta
show-snps -C -T -r "$name".pilon.8.nucmer.delta > "$name".pilon.8.nucmer.delta.log
bwa index "$name".pilon.8.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.8.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.8.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.8.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.8.fasta --frags "$name".pilon.bam --output "$name".pilon.9 

nucmer -p "$name".pilon.9.nucmer "$name".pilon.8.fasta "$name".pilon.9.fasta
show-snps -C -T -r "$name".pilon.9.nucmer.delta > "$name".pilon.9.nucmer.delta.log
bwa index "$name".pilon.9.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.9.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.9.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.9.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.9.fasta --frags "$name".pilon.bam --output "$name".pilon.10 

nucmer -p "$name".pilon.10.nucmer "$name".pilon.9.fasta "$name".pilon.10.fasta
show-snps -C -T -r "$name".pilon.10.nucmer.delta > "$name".pilon.10.nucmer.delta.log
bwa index "$name".pilon.10.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.10.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.10.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.10.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.10.fasta --frags "$name".pilon.bam --output "$name".pilon.11 

nucmer -p "$name".pilon.11.nucmer "$name".pilon.10.fasta "$name".pilon.11.fasta
show-snps -C -T -r "$name".pilon.11.nucmer.delta > "$name".pilon.11.nucmer.delta.log
bwa index "$name".pilon.11.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.11.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.11.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.11.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.11.fasta --frags "$name".pilon.bam --output "$name".pilon.12 

nucmer -p "$name".pilon.12.nucmer "$name".pilon.11.fasta "$name".pilon.12.fasta
show-snps -C -T -r "$name".pilon.12.nucmer.delta > "$name".pilon.12.nucmer.delta.log
bwa index "$name".pilon.12.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.12.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.12.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.12.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.12.fasta --frags "$name".pilon.bam --output "$name".pilon.13 

nucmer -p "$name".pilon.13.nucmer "$name".pilon.12.fasta "$name".pilon.13.fasta
show-snps -C -T -r "$name".pilon.13.nucmer.delta > "$name".pilon.13.nucmer.delta.log
bwa index "$name".pilon.13.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon.13.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fastq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fastq.gz | samtools view -u -T "$name".pilon.13.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon.13.fasta > "$name".pilon.bam 
samtools index "$name".pilon.bam
pilon --genome "$name".pilon.13.fasta --frags "$name".pilon.bam --output "$name".pilon.14 

nucmer -p "$name".pilon.14.nucmer "$name".pilon.13.fasta "$name".pilon.14.fasta
show-snps -C -T -r "$name".pilon.14.nucmer.delta > "$name".pilon.14.nucmer.delta.log
