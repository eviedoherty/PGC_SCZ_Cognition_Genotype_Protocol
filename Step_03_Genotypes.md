# __Genotypes__ 

Both binary hard call genotype files (.bed, .bim, .fam) and dosage marker call (.fam, .gz, .info, .map, .ngt) files are required for this analysis.  

Note: The dosage marker file extensions listed above are consistent with those used in PGC SCZ. However, dosage marker files may be available in alternative formats and therefore have different file extensions. 

 

## __Hard Calls__ 

For the Principal Component Analysis/Principal Component Estimation, the imputed binary genotype files i.e. hard calls, for the autosomal variants should be used to QC for high quality, high frequency variants (See __Principal Component Estimation__).  

 

## __Dosage Marker Calls__ 

Association testing should be performed using imputed dosage marker calls for all 22 autosomal chromosomes and the X chromosome. Dosage genotypes imputed via RICOPILI are output in PLINK2-dosage format, which is not compatible with GCTA fastGWA (Jiang et al., 2019). Files should therefore be converted to .bgen format using PLINK2 (see __dosage_to_bgen_universal.sh__) and then combined per chromosome (__dosage_combine_per_chr.sh__). 

 

__Information__: Light filtering should be applied to dosage marker calls prior to running the association analysis (MAF>0.005 and INFO>0.1). Please note that this filtering is automatically applied in the RICOPILI pipeline and therefore does not need to be repeated if imputation was performed via RICOPILI. 
