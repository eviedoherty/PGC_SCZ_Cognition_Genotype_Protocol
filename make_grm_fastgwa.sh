#!/bin/bash
#SBATCH --array=1-20
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=2
#SBATCH --partition=genoa        # or thin/rome, whatever your allocation uses
#SBATCH --job-name=grm_part
#SBATCH --output=grm_part_%a.out
#SBATCH --error=grm_part_%a.err


CHR=$1
N=20
i=$SLURM_ARRAY_TASK_ID

/home/edoherty/gcta-1.95.3-linux-x86_64/squashfs-root/usr/bin/gcta64 --bfile /home/edoherty/Ireland/chr${CHR}_pruned_for_fastGWA \
  --make-grm-part $N $i \
  --thread-num 1 \
  --out grm_fastgwa_datasetname
