#!/bin/bash -l
#SBATCH -D /home/jri/projects/teo_plastic
#SBATCH -J RNA-qual
#SBATCH -o outs/out.%A.%a.txt
#SBATCH -e errors/error.%A.%a.txt
#SBATCH -p bigmem

~/src/fastx-toolkit/bin/fastx_quality_stats -i data/D1_D24_pool_NoIndex_L005_R1_001.fastq -o data/D1_D24_pool_NoIndex_L005_R1_001.stats.txt -Q 33
~/src/fastx-toolkit/bin/fastq_quality_boxplot_graph.sh -i results/D1_D24_pool_NoIndex_L005_R1_001.stats.txt -o results/D1_D24_pool_NoIndex_L005_R1_001.quality.png -t "Dolores RNA" 
~/src/fastx-toolkit/bin/fastx_nucleotide_distribution_graph.sh -i results/D1_D24_pool_NoIndex_L005_R1_001.stats.txt -o results/D1_D24_pool_NoIndex_L005_R1_001.nucleotide.png -t "Dolores RNA"
