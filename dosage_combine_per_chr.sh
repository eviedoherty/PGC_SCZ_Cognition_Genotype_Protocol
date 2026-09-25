#!/bin/bash
#SBATCH --job-name=merge_bgen
#SBATCH --output=merge_bgen_%j.out
#SBATCH --error=merge_bgen_%j.err
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G

module load 2023
module load PLINK/2.00a3.7-GCC-12.3.0

DATASET="xirwt" #adjust to match your dataset name 

BGEN_DIR="/home/edoherty/Ireland/bgen_chunks/${DATASET}"
PGEN_DIR="/home/edoherty/Ireland/pgen_chunks/${DATASET}"
FINAL_DIR="/home/edoherty/Ireland/bgen_chromosomes/${DATASET}"  #adjust file paths accordingly

mkdir -p "$PGEN_DIR"
mkdir -p "$FINAL_DIR"


for bgen in "$BGEN_DIR"/*.bgen
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


for chr in {1..22}
do

    echo "========================================"
    echo "Processing chromosome $chr"
    echo "========================================"

   
    files=( "$PGEN_DIR"/*chr${chr}_*.pgen )

    if [ ${#files[@]} -eq 0 ]; then
        echo "No files found for chromosome $chr"
        continue
    fi

   
    first="${files[0]}"
    first_prefix="${first%.pgen}"

    merge_list="$PGEN_DIR/chr${chr}_merge_list.txt"
    > "$merge_list"

    for ((i=1; i<${#files[@]}; i++))
    do
        prefix="${files[$i]%.pgen}"
        echo "$prefix" >> "$merge_list"
    done


    if [ ${#files[@]} -eq 1 ]; then

        echo "Only one chunk for chromosome $chr"

        plink2 \
            --pfile "$first_prefix" \
            --make-pgen \
            --out "$PGEN_DIR/chr${chr}"

    else

        echo "Merging ${#files[@]} chunks for chromosome $chr"

        plink2 \
            --pfile "$first_prefix" \
            --pmerge-list "$merge_list" \
            --make-pgen \
            --out "$PGEN_DIR/chr${chr}"

        if [ $? -ne 0 ]; then
            echo "ERROR merging chromosome $chr"
            exit 1
        fi

    fi


    echo "Exporting chromosome $chr to BGEN"

    plink2 \
        --pfile "$PGEN_DIR/chr${chr}" \
        --export bgen-1.2 sample-v2 \
        --out "$FINAL_DIR/chr${chr}"

    if [ $? -ne 0 ]; then
        echo "ERROR exporting chromosome $chr"
        exit 1
    fi

    echo "Finished chromosome $chr"

done

echo "========================================"
echo "ALL CHROMOSOMES COMPLETE"
echo "========================================"

