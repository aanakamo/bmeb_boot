#!/bin/bash

#SBATCH --partition=Instruction         # Partition/queue to run on
#SBATCH --time=08:00:00                 # Max time for job to run (4 hours)
#SBATCH --job-name=flye_anne            # Name for job (shows when running squeue)
#SBATCH --mail-type=ALL                 # Mail events(NONE,BEGIN,END,FAIL,ALL)
#SBATCH --mail-user=aanakamo@ucsc.edu   # Where to send mail
#SBATCH --ntasks=1                      # Number of tasks to run
#SBATCH --cpus-per-task=2               # Number of CPU cores to use per task
#SBATCH --mem=4G                        # Ammount of RAM to allocate for the task
#SBATCH --output=slurm_%j.out             # Standard output and error log
#SBATCH --error=slurm_%j.err              # Standard output and error log


# Load modules to use them
module load seqkit
module load flye

# Run commands from current folder. May need to use absolute paths such as
#    /hb/home/rkparson/Workspace/bootcamp2023/

cd /hb/home/aanakamo/bootcamp2023
cd Wwil_fastq
cat *.fastq.gz > merged.fastq.gz
seqkit rmdup merged.fastq.gz -o merged.rmdup.fastq.gz

cd ..
time flye --nano-hq Wwil_fastq/merged.rmdup.fastq.gz -t 1 --out-dir flye/
