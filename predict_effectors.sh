#!/bin/bash

#SBATCH --partition=Instruction         # Partition/queue to run on
#SBATCH --time=08:00:00                 # Max time for job to run (4 hours)
#SBATCH --job-name=effector_predict            # Name for job (shows when running squeue)
#SBATCH --mail-type=ALL                 # Mail events(NONE,BEGIN,END,FAIL,ALL)
#SBATCH --mail-user=aanakamo@ucsc.edu   # Where to send mail
#SBATCH --ntasks=1                      # Number of tasks to run
#SBATCH --cpus-per-task=2               # Number of CPU cores to use per task
#SBATCH --mem=4G                        # Ammount of RAM to allocate for the task
#SBATCH --output=slurm_%j.out             # Standard output and error log
#SBATCH --error=slurm_%j.err              # Standard output and error log

### Run secreted protein annotation pipeline on each proteome individually
GENOME=$1

cd /hb/home/aanakamo/bootcamp2023/EFFECTORS

### SignalP: Determine proteins with signal peptide (membrane targeted)
export PATH="/hb/home/aanakamo/bootcamp2023/EFFECTORS/signalp-5.0b/bin:$PATH"
signalp -fasta ../FAA/${GENOME}.faa -prefix signalp_${GENOME} -org "gram-"
awk '{if ($2 == "SP(Sec/SPI)") {print $1}}' signalp_${GENOME}_summary.signalp5 > signalp_secrete_points_names_${GENOME}
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' ../FAA/${GENOME}.faa > ${GENOME}.singleline.faa

> ${GENOME}_signalp_proteins.faa
while read gene; do
    grep -A1 ${gene} ${GENOME}.singleline.faa >> ${GENOME}_signalp_proteins.faa
done < signalp_secrete_points_names_${GENOME}

### TMHMM: Determine non-membrane bound proteins
export PATH="/hb/home/aanakamo/bootcamp2023/EFFECTORS/tmhmm-2.0c/bin:$PATH"
tmhmm ${GENOME}_signalp_proteins.faa > tmhmm_output_${GENOME}

grep "Number" tmhmm_output_${GENOME} | awk '{if ($7 == 0){print $2}} ' > ${GENOME}_signalp_notmhmm_protein_names

> ${GENOME}_signalp_notmhmm_proteins.faa
while read gene; do
    grep -A1 ${gene} ${GENOME}.singleline.faa >> ${GENOME}_signalp_notmhmm_proteins.faa
done < ${GENOME}_signalp_notmhmm_protein_names
