# Principal Component Estimation 

Principal Component Estimation should be performed via the RICOPILI pipeline. Information on the installation and configuration of RICOPILI can be found at the following link: https://github.com/alicebraun/ricopili 

 

Imputed variants with high imputation quality (INFO>0.80) and low missingness (<1%) should be carried forward for further quality control. Two iterations of linkage disequilibrium pruning (r2=0.02, 200 SNP windows) and frequency filtering (MAF>0.05) should be applied to these high-quality SNPs for principal component estimation in each dataset. Long-range-LD areas should also be removed before performing PCA for each dataset (Chromosome 6: Major histocompatibility region (MHC) and Chromosome 8: Inversion region). A subsets of the first 10 principal components generated for each dataset will be included in the final association analyses (see __Covariates__).  


__Note__: All above parameters are automatically applied in RICOPILI pcaer. Please __record__ the number of remaining autosomal SNPs after applying this quality control step. This will be reported in the paper. 

Principal Component Estimation can be carried out using the pcaer function in RICOPILI. 

Before running pcaer, create symlink the directories containing the hard call files.   

## Creating Symlinks

__Step 1 - Create a new directory__ 

```bash
mkdir pca_test 
cd ./pca_test
```


__Step 2 - Create the symlinks to the .bed, .bim, and .fam within that directory (required for pcaer)__

```bash
ln -s /home/your_name/SCZ_Wave3/dataset/imputed/hardcall_genotypes_hg38_1kg/scz_dataset_eur_sr-qc.hg38.ch.fl.bgn.bim

ln -s /home/your_name/SCZ_Wave3/dataset/imputed/hardcall_genotypes_hg38_1kg/scz_dataset_eur_sr-qc.hg38.ch.fl.bgn.bed

ln -s /home/your_name/SCZ_Wave3/dataset/imputed/hardcall_genotypes_hg38_1kg/scz_dataset_eur_sr-qc.hg38.ch.fl.bgn.fam
```

## Run pcaer

```bash
/path/to/RICOPILI/rp_bin/pcaer \
  --prefercase \
  --preferfam \
  --out pca_for_dataset \
  scz_dataset_eur_sr-qc.hg38.ch.fl.bgn.bim
```

### Output 

The output file name should look like this; mds_pca_for_dataset.menv. This .menv folder will contain the PCs for your datasets (mds_pca_for_dataset.menv/pca_for_dataset.menv.emds) which should then be used in the association analysis as covariates.  

Relatedness testing was not performed as the chosen association testing method (fastGWA) accounts for population stratification and relatedness using a genetic relationship matrix (see __Association Analysis__).  
