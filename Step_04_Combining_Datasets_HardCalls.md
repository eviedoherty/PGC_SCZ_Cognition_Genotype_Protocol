Please note, this step is only applicable if you have collapsed datasets (See __Data Preparation__)

# __Hard Calls__ 



__Step 1__: Match phenotype IDs to genotype IDs using the available .fam files and generate a .txt file containing the matching IDs. Please note that this is a general guide, and individual approaches to ID matching is permitted.   
 


###__Scenario 1 - Phenotype IDs fully match genotype IDs in the IID/FID column__ 

The below code matches the phenotype IDs to the genotype IID column (column 2 .fam file; $2).  

If the phenotype IDs match the FID column (column 1 .fam file), adjust the code accordingly (adjust “__$2 in ids__” to “__$1 in ids__”): 

```bash
awk 'NR==FNR {ids[$1]; next} $2 in ids {print $1, $2}' \
./Folder/maindataset_IDs_matching_with_phenotypedataset.txt \
./SCZ_Wave3/maindataset/imputed/hardcall_genotypes_hg38_1kg/scz_maindataset_eur_sr-qc.hg38.ch.fl.bgn.fam \
> genotype_phenotype_matched_IDs.txt
```



###__Scenario 2 - Phenotype IDs partly match genotype IDs in the IID/FID column__ 

In some cases, phenotype IDs only partly match genotype IDs For example, phenotype ID: __Dub_PT-2BBQ__, FID in .fam file: __cas_scz_xdubl_eur_sr_A6.0*Dub_PT-2BBQ__.  

The below code matches these phenotype IDs to genotype IDs in the FID column (to match with IID column adjust “__{split($1,a,"*")__” to “__{split($2,a,"*")__”): 


```bash
awk 'NR==FNR {ids[$1]; next} {split($1,a,"*"); if (a[2] in ids) print $1, $2}' \
./Folder/maindataset_IDs_matching_with_phenotypedataset.txt \
./SCZ_Wave3/maindataset/imputed/hardcall_genotypes_hg38_1kg/scz_dataset_eur_sr-qc.hg38.ch.fl.bgn.fam \
> genotype_phenotype_matched_IDs.txt
```

__Note__: In the above example, the code matches phenotype IDs to genotype IDs using the portion of the genotype ID that follows __"*"__. This symbol/character may vary across datasets and therefore should be adjusted accordingly depending on the format of your genotype IDs (__i.e. “_” rather than “*”__).  


__Step 2__: Filter the hard-call genotype files (binary files) to retain only individuals with available phenotypic data (i.e. a g-factor value). This ensures that PCs are generated in the same population included in the downstream association analysis. 

Repeat the below code for each dataset you wish to merge i.e. if you have three datasets you wish to merge, then repeat the below code for all three datasets: 


```bash
plink2 \
  --bfile ./SCZ_Wave3/maindataset/imputed/hardcall_genotypes_hg38_1kg/scz_dataset_eur_sr-qc.hg38.ch.fl.bgn \
  --keep ./folder/genotype_phenotype_matched_IDs.txt \
  --make-bed \
  --out hardcall_file_matched_IDs_dataset
```

__Step 3__: Merge the datasets.  

First, generate a merge list: 


```bash
cat > merge_list_name.txt << EOF 
hardcall_file_matched_IDs_dataset_1 
hardcall_file_matched_IDs_dataset_2 
EOF 
```

Then, merge all files into a single dataset: 


```bash
plink \
  --bfile hardcall_file_matched_IDs_dataset_3 \
  --merge-list merge_list_name.txt \
  --make-bed \
  --out dataset_hardcalls_merged_for_PCE
```

__Note__: This is a PLINK 1.9 command.  

Your hard calls are now ready for __Principal Component Estimation__.  
