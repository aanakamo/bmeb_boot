#!/bin/bash

#SBATCH --partition=Instruction         # Partition/queue to run on
#SBATCH --time=12:00:00                 # Max time for job to run
#SBATCH --job-name=orthofinder           # Name for job (shows when running squeue)
#SBATCH --mail-type=ALL                 # Mail events(NONE,BEGIN,END,FAIL,ALL)
#SBATCH --mail-user=aanakamo@ucsc.edu   # Where to send mail
#SBATCH --ntasks=1                      # Number of tasks to run
#SBATCH --cpus-per-task=20               # Number of CPU cores to use per task
#SBATCH --mem=4G                        # Ammount of RAM to allocate for the task
#SBATCH --output=slurm_%j.out             # Standard output and error log
#SBATCH --error=slurm_%j.err              # Standard output and error log

### Run OrthoFinder on Wolbachia proteomes

cd /hb/home/aanakamo/bootcamp2023/ORTHOFINDER

source activate /hb/home/aanakamo/.conda/envs/OrthoFinder3
orthofinder -f ../FAA -t 20 -a 5 -M msa -A mafft -T fasttree -o OrthoFinder_out # -S diamond_ultra_sens
conda deactivate
