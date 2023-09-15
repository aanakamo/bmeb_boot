#!/bin/bash

#SBATCH --partition=Instruction         # Partition/queue to run on
#SBATCH --time=08:00:00                 # Max time for job to run (4 hours)
#SBATCH --job-name=orthofinder_install            # Name for job (shows when running squeue)
#SBATCH --mail-type=ALL                 # Mail events(NONE,BEGIN,END,FAIL,ALL)
#SBATCH --mail-user=aanakamo@ucsc.edu   # Where to send mail
#SBATCH --ntasks=1                      # Number of tasks to run
#SBATCH --cpus-per-task=2               # Number of CPU cores to use per task
#SBATCH --mem=4G                        # Ammount of RAM to allocate for the task
#SBATCH --output=slurm_%j.out             # Standard output and error log
#SBATCH --error=slurm_%j.err              # Standard output and error log

cd /hb/home/aanakamo/bootcamp2023/EFFECTORS

### SignalP
# wget https://services.healthtech.dtu.dk/download/bd014f23-3a12-4466-9df0-2a0114c3743d/signalp-5.0b.Linux.tar.gz
# tar -xvzf *tar.gz

### tmhmm
wget https://services.healthtech.dtu.dk/download/b133f4f0-f31c-4fbd-8fa2-484318266e7a/tmhmm-2.0c.Linux.tar.gz
tar -xvzf *tar.gz

### EffectorP


