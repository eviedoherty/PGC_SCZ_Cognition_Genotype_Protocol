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
    -g /home/edoherty/Ireland/bgen_chromosomes_chr${CHR}/chr${CHR}_merged_males.bgen \
    -s /home/edoherty/Ireland/bgen_chromosomes_chr${CHR}/chr${CHR}_merged_males_fixed.sample \
    -g /home/edoherty/Ireland/bgen_chromosomes_chr${CHR}/chr${CHR}_merged_males.bgen \
    -s /home/edoherty/Ireland/bgen_chromosomes_chr${CHR}/chr${CHR}_merged_males_fixed.sample \
    -og /home/edoherty/Ireland/chr${CHR}_merged_all_males.bgen \
    -os /home/edoherty/Ireland/chr${CHR}_merged_all_nonpar.sample
