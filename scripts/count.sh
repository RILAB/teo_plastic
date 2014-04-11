#!/bin/bash -l
#SBATCH -D /home/jri/projects/teo_plastic
#SBATCH -J RNA-count
#SBATCH -o outs/out.%j.txt
#SBATCH -e errors/error.%j.txt
#SBATCH -p bigmem

file=$1
prefix=$( echo $file | cut -d "." -f 1 )

cd data
samtools view -S -b $file | samtools sort -n - sorted.$prefix
samtools view -o $prefix.sorted.sam sorted.$prefix.bam

#python -m HTSeq.scripts.count -s no -a 30 $prefix.sorted.sam new.gff3 > $prefix.count
python -m HTSeq.scripts.count -s no $prefix.sorted.sam new.gff3 > results/$prefix.0.count
