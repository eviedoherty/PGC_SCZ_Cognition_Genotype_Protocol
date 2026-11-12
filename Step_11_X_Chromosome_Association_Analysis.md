# Chromosome X  

The association analysis for chromosome X should be performed separately for male and female samples. Gene dosages in males should be scored 0 or 2 and in females as 0/1/2.  

__Note__: This scoring has already been applied to the PGC SCZ chromosome X dosage files available on Snellius. Nevertheless, please double-check prior to running the analysis.  

Due to the haploid nature of non-par regions in males, using .bgen formatted files with male X chromosome dosages will flag the following error in fastGWA:  

Error: multiploidy detected in 0th SNP 

As suggested by the developers of GCTA fastGWA, .pgen files should be used to run the X chromosome analysis in fastGWA as they can cope with the haploid/diploid disparity without flagging an error. Chromosome X file should be converted (dosage_to_bgen_universal.sh) and merged (dosage_combine_per_chr.sh and merge_all_dataset_chrs.sh (if applicable)) using the same approach as autosomes. 

## Convert files to .pgen format 

```bash
plink2 \ 
  --bgen /path/to/bgen_files/edoherty/chrX_males.bgen ref-first \ 
  --sample /path/to/bgen_samples_files/chrX_males_fixed.sample \ 
  --make-pgen \ 
  --out chrX_males_only_dataset
```

__Note__: While the analysis will successfully run using .bgen format for female samples, to retain consistency, we ask that .pgen format is used for both males and females when running the association analysis on the X chromosome. Therefore, the above step shoud be performed for both males and females. 


## Running the X chromosome analyses: 

```bash
/path/to/gcta-1.95.3-linux-x86_64/squashfs-root/usr/bin/gcta64    
--pfile /path/to/pfile/chrX_males_only_dataset   
--grm-sparse /path/to/sparse_grm/grm_fastgwa_sparse  
--fastGWA-mlm  
--dc 1   
--pheno /path/to/phenotype_file/dataset_pheno_g.tsv     
--qcovar /path/to/qcovar_file/dataset_qcovars.tsv   
--thread-num 10    
--out fastGWA_cX_males_dataset 
```


__Note__: Sex should not be included as a covariate as the association analysis on the X chromosome is performed separately for males and females.   
