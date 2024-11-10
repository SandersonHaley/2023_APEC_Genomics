#!/bin/bash 
name=$1
source activate snippy
snippy --cpus 8 --outdir "$name"_snippy --ref "$name".pilon2.14.fasta --R1 ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz --R2 ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz --force
cp ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/snps.vcf ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/corrections.vcf 
bgzip -c ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/corrections.vcf > ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/corrections.vcf.gz

source activate tabix
tabix -f -p vcf ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/corrections.vcf.gz
cat "$name".pilon2.14.fasta| ~/.conda/envs/vcftools/bin/vcf-consensus ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/corrections.vcf.gz > ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/"$name"_corrected.fa

source activate polishing
bwa index ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/"$name"_corrected.fa
bwa mem  -v 2 -M -t 15 ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/"$name"_corrected.fa ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/"$name"_corrected.fa -F 3844 -q 60 | samtools sort --reference ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/"$name"_corrected.fa > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/"$name"_corrected.fa --frags "$name".pilon3.bam --output "$name".pilon3.0 

nucmer -p "$name".pilon3.0.nucmer ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_polishing/"$name"_snippy/"$name"_corrected.fa "$name".pilon3.0.fasta
show-snps -C -T -r "$name".pilon3.0.nucmer.delta > "$name".pilon3.0.nucmer.delta.log
bwa index "$name".pilon3.0.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.0.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.0.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.0.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.0.fasta --frags "$name".pilon3.bam --output "$name".pilon3.1 

nucmer -p "$name".pilon3.1.nucmer "$name".pilon3.0.fasta "$name".pilon3.1.fasta
show-snps -C -T -r "$name".pilon3.1.nucmer.delta > "$name".pilon3.1.nucmer.delta.log
bwa index "$name".pilon3.1.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.1.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.1.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.1.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.1.fasta --frags "$name".pilon3.bam --output "$name".pilon3.2 

nucmer -p "$name".pilon3.2.nucmer "$name".pilon3.1.fasta "$name".pilon3.2.fasta
show-snps -C -T -r "$name".pilon3.2.nucmer.delta > "$name".pilon3.2.nucmer.delta.log
bwa index "$name".pilon3.2.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.2.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.2.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.2.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.2.fasta --frags "$name".pilon3.bam --output "$name".pilon3.3 

nucmer -p "$name".pilon3.3.nucmer "$name".pilon3.2.fasta "$name".pilon3.3.fasta
show-snps -C -T -r "$name".pilon3.3.nucmer.delta > "$name".pilon3.3.nucmer.delta.log
bwa index "$name".pilon3.3.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.3.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.3.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.3.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.3.fasta --frags "$name".pilon3.bam --output "$name".pilon3.4 

nucmer -p "$name".pilon3.4.nucmer "$name".pilon3.3.fasta "$name".pilon3.4.fasta
show-snps -C -T -r "$name".pilon3.4.nucmer.delta > "$name".pilon3.4.nucmer.delta.log
bwa index "$name".pilon3.4.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.4.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.4.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.4.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.4.fasta --frags "$name".pilon3.bam --output "$name".pilon3.5 

nucmer -p "$name".pilon3.5.nucmer "$name".pilon3.4.fasta "$name".pilon3.5.fasta
show-snps -C -T -r "$name".pilon3.5.nucmer.delta > "$name".pilon3.5.nucmer.delta.log
bwa index "$name".pilon3.5.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.5.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.5.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.5.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.5.fasta --frags "$name".pilon3.bam --output "$name".pilon3.6 

nucmer -p "$name".pilon3.6.nucmer "$name".pilon3.5.fasta "$name".pilon3.6.fasta
show-snps -C -T -r "$name".pilon3.6.nucmer.delta > "$name".pilon3.6.nucmer.delta.log
bwa index "$name".pilon3.6.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.6.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.6.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.6.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.6.fasta --frags "$name".pilon3.bam --output "$name".pilon3.7 

nucmer -p "$name".pilon3.7.nucmer "$name".pilon3.6.fasta "$name".pilon3.7.fasta
show-snps -C -T -r "$name".pilon3.7.nucmer.delta > "$name".pilon3.7.nucmer.delta.log
bwa index "$name".pilon3.7.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.7.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.7.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.7.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.7.fasta --frags "$name".pilon3.bam --output "$name".pilon3.8 

nucmer -p "$name".pilon3.8.nucmer "$name".pilon3.7.fasta "$name".pilon3.8.fasta
show-snps -C -T -r "$name".pilon3.8.nucmer.delta > "$name".pilon3.8.nucmer.delta.log
bwa index "$name".pilon3.8.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.8.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.8.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.8.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.8.fasta --frags "$name".pilon3.bam --output "$name".pilon3.9 

nucmer -p "$name".pilon3.9.nucmer "$name".pilon3.8.fasta "$name".pilon3.9.fasta
show-snps -C -T -r "$name".pilon3.9.nucmer.delta > "$name".pilon3.9.nucmer.delta.log
bwa index "$name".pilon3.9.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.9.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.9.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.9.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.9.fasta --frags "$name".pilon3.bam --output "$name".pilon3.10 

nucmer -p "$name".pilon3.10.nucmer "$name".pilon3.9.fasta "$name".pilon3.10.fasta
show-snps -C -T -r "$name".pilon3.10.nucmer.delta > "$name".pilon3.10.nucmer.delta.log
bwa index "$name".pilon3.10.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.10.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.10.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.10.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.10.fasta --frags "$name".pilon3.bam --output "$name".pilon3.11 

nucmer -p "$name".pilon3.11.nucmer "$name".pilon3.10.fasta "$name".pilon3.11.fasta
show-snps -C -T -r "$name".pilon3.11.nucmer.delta > "$name".pilon3.11.nucmer.delta.log
bwa index "$name".pilon3.11.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.11.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.11.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.11.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.11.fasta --frags "$name".pilon3.bam --output "$name".pilon3.12 

nucmer -p "$name".pilon3.12.nucmer "$name".pilon3.11.fasta "$name".pilon3.12.fasta
show-snps -C -T -r "$name".pilon3.12.nucmer.delta > "$name".pilon3.12.nucmer.delta.log
bwa index "$name".pilon3.12.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.12.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.12.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.12.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.12.fasta --frags "$name".pilon3.bam --output "$name".pilon3.13 

nucmer -p "$name".pilon3.13.nucmer "$name".pilon3.12.fasta "$name".pilon3.13.fasta
show-snps -C -T -r "$name".pilon3.13.nucmer.delta > "$name".pilon3.13.nucmer.delta.log
bwa index "$name".pilon3.13.fasta 
bwa mem  -v 2 -M -t 15 "$name".pilon3.13.fasta ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_1.fq.gz ~/Unassembled_polishing/"$name"_longreadpolishing/"$name"_SR_2.fq.gz | samtools view -u -T "$name".pilon3.13.fasta -F 3844 -q 60 | samtools sort --reference "$name".pilon3.13.fasta > "$name".pilon3.bam 
samtools index "$name".pilon3.bam
pilon --genome "$name".pilon3.13.fasta --frags "$name".pilon3.bam --output "$name".pilon3.14 

nucmer -p "$name".pilon3.14.nucmer "$name".pilon3.13.fasta "$name".pilon3.14.fasta
show-snps -C -T -r "$name".pilon3.14.nucmer.delta > "$name".pilon3.14.nucmer.delta.log
