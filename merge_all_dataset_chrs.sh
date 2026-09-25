#!/bin/bash
#SBATCH --job-name=merge_chr
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --output=merge_chr%a_%j.out
#SBATCH --error=merge_chr%a_%j.err

CHR=$1  

/home/edoherty/qctool/build/release/apps/qctool_v2.2.0 \
    -g /home/edoherty/Ireland/bgen_chromosomes/du2aa/chr${CHR}.bgen \
    -s /home/edoherty/Ireland/bgen_chromosomes/du2aa/chr${CHR}.sample \
    -g /home/edoherty/Ireland/bgen_chromosomes/xdubl/chr${CHR}.bgen \
    -s /home/edoherty/Ireland/bgen_chromosomes/xdubl/chr${CHR}.sample \
    -g /home/edoherty/Ireland/bgen_chromosomes/xirwt/chr${CHR}.bgen \
    -s /home/edoherty/Ireland/bgen_chromosomes/xirwt/chr${CHR}.sample \
    -og /home/edoherty/Ireland/bgen_chromosomes/chr${CHR}_merged.bgen \
    -os /home/edoherty/Ireland/bgen_chromosomes/chr${CHR}_merged.sample
