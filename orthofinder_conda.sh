#!/bin/bash

#SBATCH --partition=Instruction         # Partition/queue to run on
#SBATCH --time=08:00:00                 # Max time for job to run (4 hours)
#SBATCH --job-name=orthofinder_install            # Name for job (shows when running squeue)
#SBATCH --mail-type=ALL                 # Mail events(NONE,BEGIN,END,FAIL,ALL)
#SBATCH --mail-user=aanakamo@ucsc.edu   # Where to send mail
#SBATCH --ntasks=1                      # Number of tasks to run
#SBATCH --cpus-per-task=2               # Number of CPU cores to use per task
#SBATCH --output=slurm_%j.out             # Standard output and error log
#SBATCH --error=slurm_%j.err              # Standard output and error log

cd /hb/home/aanakamo/bootcamp2023

#conda create -y -n OrthoFinder
source activate /hb/home/aanakamo/.conda/envs/OrthoFinder
echo "*** ACTIVATED ***"
#conda install -y -c bioconda orthofinder
conda install -y -c bioconda python=3.7
echo "*** python installed ***"
conda install -y -c bioconda diamond=0.9.4
echo "*** diamond installed ***"
conda deactivate
