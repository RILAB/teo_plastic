#!/bin/bash -l
#SBATCH -D /home/jri/projects/teo_plastic
#SBATCH -J RNA-star
#SBATCH -o outs/out.%A.%a.txt
#SBATCH -e errors/error.%A.%a.txt
#SBATCH -p bigmem
#SBATCH --ntasks=8

~/src/STAR_2.3.0e.Linux_x86_64/STAR --runMode genomeGenerate --genomeDir /home/jri/projects/teo_plastic/data/ --genomeFastaFiles /home/jri/projects/teo_plastic/data/Zea_mays.AGPv3.21.dna_rm.genome.fa --runThreadN 8
