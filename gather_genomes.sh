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
    name=$(echo ${line} | awk '{ print $1 }')
    fna=$(echo ${line} | awk '{ print $2 }')
    gff=$(echo ${line} | awk '{ print $3 }')
    faa=$(echo ${line} | awk '{ print $4 }')
    wget -O FNA/${name}.fna.gz ${fna}
    gunzip FNA/${name}.fna.gz
    wget -O GFF/${name}.gff.gz ${gff}
    gunzip GFF/${name}.gff.gz
    wget -O FAA/${name}.faa.gz ${faa}
    gunzip FAA/${name}.faa.gz
done

### rename FAA proteins to be more descriptive for viewing in phylogeny (subgroup, wolbachia species, genome name)
cat Wolbachia_genome_tbl.txt | while read line; do
    name=$(echo ${line} | awk '{ print $1 }')
    fna=$(echo ${line} | awk '{ print $2 }')
    gff=$(echo ${line} | awk '{ print $3 }')
    faa=$(echo ${line} | awk '{ print $4 }')
    old="WP_"
    new="${name}_WP_"
    sed -i "s/$old/$new/g" FAA/${name}.faa
done
