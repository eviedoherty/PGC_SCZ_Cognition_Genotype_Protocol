#!/bin/bash
#SBATCH --job-name=merge_bgen_chrX
#SBATCH --output=merge_bgen_chrX_%j.out
#SBATCH --error=merge_bgen_chrX_%j.err
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G

module load 2023
module load PLINK/2.00a3.7-GCC-12.3.0

DATASET="xdubl"

BGEN_DIR="/home/edoherty/Ireland/bgen_chunks_chrX/${DATASET}"
PGEN_DIR="/home/edoherty/Ireland/pgen_chunks_chrX/${DATASET}"
FINAL_DIR="/home/edoherty/Ireland/bgen_chromosomes_chrX/${DATASET}"

mkdir -p "$PGEN_DIR" "$FINAL_DIR"

# 1. Convert only the chrX chunks to PGEN
for bgen in "$BGEN_DIR"/*chrX_*.bgen
do
    base=$(basename "$bgen" .bgen)
    echo "Converting $base"

    plink2 \
        --bgen "$bgen" ref-first \
        --sample "${bgen%.bgen}.sample" \
        --make-pgen \
        --out "$PGEN_DIR/$base"

    if [ $? -ne 0 ]; then
        echo "ERROR converting $base"
        exit 1
    fi
done

# 2. Merge the chrX chunks
files=( "$PGEN_DIR"/*chrX_*.pgen )

if [ ${#files[@]} -eq 0 ]; then
    echo "No chrX chunks found"
    exit 1
fi

first_prefix="${files[0]%.pgen}"
merge_list="$PGEN_DIR/chrX_merge_list.txt"
> "$merge_list"

for ((i=1; i<${#files[@]}; i++))
do
    echo "${files[$i]%.pgen}" >> "$merge_list"
done

if [ ${#files[@]} -eq 1 ]; then
    plink2 --pfile "$first_prefix" --make-pgen --out "$PGEN_DIR/chrX"
else
    echo "Merging ${#files[@]} chunks"
    plink2 \
        --pfile "$first_prefix" \
        --pmerge-list "$merge_list" \
        --make-pgen \
        --out "$PGEN_DIR/chrX"
    if [ $? -ne 0 ]; then
        echo "ERROR merging chrX"
        exit 1
    fi
fi

# 3. Export to BGEN
plink2 \
    --pfile "$PGEN_DIR/chrX" \
    --export bgen-1.2 sample-v2 \
    --out "$FINAL_DIR/chrX_females"

echo "chrX complete"
