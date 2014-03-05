#!/bin/bash -l
#SBATCH -D /home/jri/projects/teo_plastic
#SBATCH -J RNA-star
#SBATCH -o outs/out.%A.%a.txt
#SBATCH -e errors/error.%A.%a.txt
#SBATCH -p bigmem
#SBATCH --ntasks=8
#SBATCH --array=1-10

cd data/
file=$( sed -n "$SLURM_ARRAY_TASK_ID"p $1 )

echo $file

~/src/STAR_2.3.0e.Linux_x86_64/STAR --genomeDir /home/jri/projects/teo_plastic/data/ --readFilesIn /home/jri/projects/teo_plastic/data/$file --runThreadN 8 --outFileNamePrefix $file
