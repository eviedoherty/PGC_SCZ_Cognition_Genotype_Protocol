# Sex-stratified Association Analyses 

The sex-specific association analyses should be performed on males and females independently using the same approach outlined for the main association analyses (see __Main Association Analysis__).   

Sex data can be acquired from the .sample/.fam file for each dataset, where 1=Male and 2=Female, or the covariate file containing sex (--covar). A list of individuals to keep should be generated from the .sample/.fam/covariates file and then included in the sex-specific analysis.  


## Generate the list of samples to keep 

Please note that this is a general guide, and individual approaches to generating a list of male/female IDs are permitted. 

```bash
awk 'NR > 2 && $3 == "male" {print $1, $1}' OFS='\t' covar_file_containing_sex_data.tsv > /path/for/output/male_ids_dataset.txt
```


```bash
awk 'NR > 2 && $3 == "female" {print $1, $1}' OFS='\t' covar_file_containing_sex_data.tsv > /path/for/output/female_ids_dataset.txt
```

## Run the sex-specific analyses: 

```bash
/path/to/gcta-1.95.3-linux-x86_64/squashfs-root/usr/bin/gcta64 \ 
  --bgen /path/to/bgen_files/chr1_merged.bgen \ 
  --sample /path/to/bgen_sample_files/chr1_merged_fixed.sample \ 
  --grm-sparse /path/to/sparse_grm/grm_fastgwa_sparse \ 
  --fastGWA-mlm \ 
  --pheno /path/to/phenotype_file/dataset_pheno_g.tsv \ 
  --qcovar /path/to/qcovar_file/dataset_qcovars.tsv \ 
  --covar /path/to/covar_file/dataset_covars.tsv \ 
  --keep /path/to/list/of/IDs_to_keep/male_ids_dataset.txt \   #adjust the –keep accordingly 
  --thread-num 10 \ 
  --out /path/for/output/fastGWA_c1_male_only_dataset
```

__Note__: This can be looped for efficiency. 
