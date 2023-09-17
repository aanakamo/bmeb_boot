#!/bin/bash

#SBATCH --partition=Instruction         # Partition/queue to run on
#SBATCH --time=08:00:00                 # Max time for job to run (4 hours)
#SBATCH --job-name=mmseqs2            # Name for job (shows when running squeue)
#SBATCH --mail-type=ALL                 # Mail events(NONE,BEGIN,END,FAIL,ALL)
#SBATCH --mail-user=aanakamo@ucsc.edu   # Where to send mail
#SBATCH --ntasks=1                      # Number of tasks to run
#SBATCH --cpus-per-task=2               # Number of CPU cores to use per task
#SBATCH --output=slurm_%j.out             # Standard output and error log
#SBATCH --error=slurm_%j.err              # Standard output and error log

cd /hb/home/aanakamo/bootcamp2023/EFFECTORS

#conda create -y -n MMseqs2
source activate /hb/home/aanakamo/.conda/envs/MMseqs2
#conda install -y -c conda-forge -c bioconda mmseqs2

### cluster putative secreted proteins
mkdir ALL_SECRETED_mmseqs2 ALL_SECRETED_tmp
cat *_signalp_notmhmm_proteins.faa > ALL_SECRETED.faa
mmseqs createdb ALL_SECRETED.faa ALL_SECRETED.DB
mmseqs cluster ALL_SECRETED.DB ALL_SECRETED_mmseqs2 ALL_SECRETED_tmp

conda deactivate
