#!/bin/bash

#SBATCH --partition=Instruction         # Partition/queue to run on
#SBATCH --time=08:00:00                 # Max time for job to run (4 hours)
#SBATCH --job-name=genomes_anne            # Name for job (shows when running squeue)
#SBATCH --mail-type=ALL                 # Mail events(NONE,BEGIN,END,FAIL,ALL)
#SBATCH --mail-user=aanakamo@ucsc.edu   # Where to send mail
#SBATCH --ntasks=1                      # Number of tasks to run
#SBATCH --cpus-per-task=2               # Number of CPU cores to use per task
#SBATCH --mem=4G                        # Ammount of RAM to allocate for the task
#SBATCH --output=slurm_%j.out             # Standard output and error log
#SBATCH --error=slurm_%j.err              # Standard output and error log

cd /hb/home/aanakamo/bootcamp2023
mkdir -p FNA GFF FAA

### download fna, gff, and faa from NCBI
cat Wolbachia_genome_tbl.txt | while read line; do
    name=$(echo ${line} | awk -v FS="\t" '{ print $9 }')
    fna=$(echo ${line} | awk -v FS="\t" '{ print $10 }')
    gff=$(echo ${line} | awk -v FS="\t" '{ print $11 }')
    faa=$(echo ${line} | awk -v FS="\t" '{ print $12 }')
    wget -O FNA/${name}.fna.gz ${fna}
    gunzip FNA/${name}.fna.gz
    wget -O GFF/${name}.gff.gz ${gff}
    gunzip GFF/${name}.gff.gz
    wget -O FAA/${name}.faa.gz ${faa}
    gunzip FAA/${name}.faa.gz
done


