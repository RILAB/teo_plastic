# RNAseq

## Data quality checks:

fastx_quality_stats -i BC54.fq -o bc54_stats.txt
fastq_quality_boxplot_graph.sh -i bc54_stats.txt -o bc54_quality.png -t "My Library"
fastx_nucleotide_distribution_graph.sh -i bc54_stats.txt -o bc54_nuc.png -t "My Library"

## Demultiplex

run demultiplex.sh script: sbatch -p bigmem demultiplex FILE NUM_MISMATCHES

this demultiplexes and trims barcodes and adapters, leaving with name.btrim.atrim for each individual
uses scythe to trim adapters currently and fastx-toolkit to demultiplex and trim barcodes







