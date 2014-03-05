#!/bin/bash -l
#SBATCH -D /home/jri/projects/teo_plastic
#SBATCH -J RNA-count
#SBATCH -o outs/out.%A.%a.txt
#SBATCH -e errors/error.%A.%a.txt
#SBATCH -p bigmem

file=$1
prefix=$( echo $file | cut -d "." -f 1 )

cd data
#samtools view -S -b $file | samtools sort -n - sorted.$prefix
#samtools view -o $prefix.sorted.sam sorted.$prefix.bam

#python -m HTSeq.scripts.count -s no -a 20 $prefix.sorted.sam Zea_mays.AGPv3.21.gff3 > $prefix.count
python -m HTSeq.scripts.count -s no -a 20 $prefix.sorted.sam Zm.AGPv3.gff3 > $prefix.count
