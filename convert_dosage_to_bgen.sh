#!/bin/bash
#SBATCH --job-name=dosage_bgen
#SBATCH --output=dosage_bgen_%j.out
#SBATCH --error=dosage_bgen_%j.err
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G

module load 2023
module load PLINK/2.00a3.7-GCC-12.3.0


DATASET="xirwt"   #adjust to match your dataset name 

DOSAGE_DIR="/home/edoherty/SCZ_Wave3/${DATASET}/imputed/dosage_genotypes_hg38_1kg"  #adjust file path to your dosage file directory

OUT_DIR="/home/edoherty/Ireland/bgen_chunks/${DATASET}"   #adjust file path to your chosen output directory

mkdir -p "$OUT_DIR"

for dosage in "$DOSAGE_DIR"/*.out.dosage.gz
do

    prefix="${dosage%.dosage.gz}"

    fam="${prefix}.dosage.fam"
    map="${prefix}.dosage.map"

    base=$(basename "$prefix")

    echo "========================================"
    echo "Processing: $base"
    echo "DOSAGE: $dosage"
    echo "FAM:    $fam"
    echo "MAP:    $map"
    echo "========================================"

    plink2 \
        --import-dosage "$dosage" format=2 \
        --fam "$fam" \
        --map "$map" \
        --export bgen-1.2 sample-v2 \
        --out "$OUT_DIR/$base"

    if [ $? -ne 0 ]; then
        echo "ERROR processing $base"
    else
        echo "Finished $base"
    fi

done
