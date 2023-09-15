#!/bin/bash

#SBATCH --partition=Instruction         # Partition/queue to run on
#SBATCH --time=08:00:00                 # Max time for job to run (4 hours)
#SBATCH --job-name=busco_anne            # Name for job (shows when running squeue)
#SBATCH --mail-type=ALL                 # Mail events(NONE,BEGIN,END,FAIL,ALL)
#SBATCH --mail-user=aanakamo@ucsc.edu   # Where to send mail
#SBATCH --ntasks=1                      # Number of tasks to run
#SBATCH --cpus-per-task=2               # Number of CPU cores to use per task
#SBATCH --mem=4G                        # Ammount of RAM to allocate for the task
#SBATCH --output=slurm_%j.out             # Standard output and error log
#SBATCH --error=slurm_%j.err              # Standard output and error log

cd /hb/home/aanakamo/bootcamp2023
module load busco
mkdir -p BUSCO
cd BUSCO

genome_name=$1
lineage=$2

### run busco on the Wolbachia assemblies
busco -i ../FNA/${genome_name}.fna -o ${genome_name} -l ${lineage} -m genome -c ${SLURM_NTASKS} -f --download_path ${genome_name}

## to start individual jobs for each genome using this script, run:
# cd ~
# lineage="rickettsiales_odb10"
# cat bootcamp2023/Wolbachia_genome_tbl.txt | while read line; do
#     name=$(echo ${line} | awk '{ print $1 }')
#     sbatch bmeb_boot/busco.sh ${name} ${lineage}
# done
