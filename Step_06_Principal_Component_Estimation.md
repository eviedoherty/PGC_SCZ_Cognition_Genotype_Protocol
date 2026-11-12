# Principal Component Estimation 

Principal Component Estimation should be performed via the RICOPILI pipeline. Information on the installation and configuration of RICOPILI can be found at the following link: https://github.com/alicebraun/ricopili 

 

Imputed variants with high imputation quality (INFO>0.80) and low missingness (<1%) should be carried forward for further quality control. Two iterations of linkage disequilibrium pruning (r2=0.02, 200 SNP windows) and frequency filtering (MAF>0.05) should be applied to these high-quality SNPs for principal component estimation in each dataset. Long-range-LD areas should also be removed before performing PCA for each dataset (Chromosome 6: Major histocompatibility region (MHC) and Chromosome 8: Inversion region). A subsets of the first 10 principal components generated for each dataset will be included in the final association analyses (see __Covariates__).  
