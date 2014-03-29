# RNAseq

## Data quality checks:

run qual.sh that gives basic quality breakdown of data.

## Demultiplex

run demultiplex.sh script: sbatch -p bigmem demultiplex FILE NUM_MISMATCHES

this demultiplexes and trims barcodes and adapters, leaving with name.btrim.atrim for each individual
uses scythe to trim adapters currently and fastx-toolkit to demultiplex and trim barcodes

## STAR

run star_genome.sh to generate genome data for STAR

run star_map FILE where file is a list of .atrim (trimmed for adapters) fastq files.  outputs sam format and logfile.

## gff3

Download gff3 from Ensembl, then modify for HTseq thusly:

perl -e 'open FILE, "<Zea_mays.AGPv3.21.gff3"; while(<FILE>){ if($_=~m/ID/ ){ $_=~s/ID/gene_id/; $_=~s/_E\d\d//; $_=~s/_T\d\d//; $_=~s/\.exon\d+//; $_=~s/_FGP/_FG/; } print $_; }' > new.gff3


