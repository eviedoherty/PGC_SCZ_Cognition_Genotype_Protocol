Please note, this step is only applicable if you have collapsed datasets (See __Data Preparation__)

__Hard Calls__ 

__Step 1__: Match phenotype IDs to genotype IDs using the available .fam files and generate a .txt file containing the matching IDs. Please note that this is a general guide, and individual approaches to ID matching is permitted.   
 


__Scenario 1 - Phenotype IDs fully match genotype IDs in the IID/FID column__ 

The below code matches the phenotype IDs to the genotype IID column (column 2 .fam file; $2).  

If the phenotype IDs match the FID column (column 1 .fam file), adjust the code accordingly (adjust “__$2 in ids__” to “__$1 in ids__”): 

```bash
awk 'NR==FNR {ids[$1]; next} $2 in ids {print $1, $2}' ./Folder/maindataset_IDs_matching_with_phenotypedataset.txt ./SCZ_Wave3/maindataset/imputed/hardcall_genotypes_hg38_1kg/scz_maindataset_eur_sr-qc.hg38.ch.fl.bgn.fam > genotype_phenotype_matched_IDs.txt
```
