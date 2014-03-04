#!/bin/bash -l
#SBATCH -D /home/jri/projects/teo_plastic
#SBATCH -J RNA-trim
#SBATCH -o outs/out.%A.%a.txt
#SBATCH -e errors/error.%A.%a.txt
#SBATCH -p bigmem

#DEMULTIPLEX BARCODES USING FASTX TOOLIT
#cat $1 | /home/jri/src/fastx-toolkit/bin/fastx_barcode_splitter.pl --bcfile barcodes.txt --bol --mismatches $2 --prefix ./data/ --suffix ".$2.txt"

#TRIM BARCODES
cd data/
for i in *.$2.txt; do 
~/src/fastx-toolkit/bin/fastx_trimmer -f 7 -i $i -Q 33 -o $i.btrim;
~/src/scythe/scythe -a adapter_file.fasta -o $i.btrim.atrim -M 10 $i.btrim
#~/src/fastx-toolkit/bin/fastx_clipper -a ADAPTER -l 10 -n ACACTCTTTCCCTACACGACGCTCTTCCGATCT
done


