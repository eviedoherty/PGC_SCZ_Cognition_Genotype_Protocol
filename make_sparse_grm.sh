#!/bin/bash
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=2
#SBATCH --partition=genoa
#SBATCH --job-name=grm_sparse
#SBATCH --output=grm_sparse.out
#SBATCH --error=grm_sparse.err

cd /home/edoherty/Ireland

GCTA_BIN=/home/edoherty/gcta-1.95.3-linux-x86_64/squashfs-root/usr/bin/gcta64

export OPENBLAS_NUM_THREADS=1
export OMP_NUM_THREADS=1

$GCTA_BIN --grm grm_fastgwa_datasetname \
  --make-bK-sparse 0.05 \
  --out grm_fastgwa_sparse
