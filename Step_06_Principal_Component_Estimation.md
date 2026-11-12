# Principal Component Estimation 

Principal Component Estimation should be performed via the RICOPILI pipeline. Information on the installation and configuration of RICOPILI can be found at the following link: https://github.com/alicebraun/ricopili 

 

Imputed variants with high imputation quality (INFO>0.80) and low missingness (<1%) should be carried forward for further quality control. Two iterations of linkage disequilibrium pruning (r2=0.02, 200 SNP windows) and frequency filtering (MAF>0.05) should be applied to these high-quality SNPs for principal component estimation in each dataset. Long-range-LD areas should also be removed before performing PCA for each dataset (Chromosome 6: Major histocompatibility region (MHC) and Chromosome 8: Inversion region). A subsets of the first 10 principal components generated for each dataset will be included in the final association analyses (see __Covariates__).  


__Note__: All above parameters are automatically applied in RICOPILI pcaer. Please __record__ the number of remaining autosomal SNPs after applying this quality control step. This will be reported in the paper. 

Principal Component Estimation can be carried out using the pcaer function in RICOPILI. 

Before running pcaer, create symlink the directories containing the hard call files:  

## Creating Symlinks

__Step 1 - Create a new directory__ 

```bash
mkdir pca_test 
cd ./pca_test
```
