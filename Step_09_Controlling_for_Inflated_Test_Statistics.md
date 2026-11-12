# Controlling for Inflated Test Statistics  

To evaluate the effectiveness of quality control parameters on the genome-wide inflation of test statistics, a lambda genomic control (GC) calculation (Devlin & Roeder, 1999) should be performed. This should be performed on the combined summary statistics for a dataset (Chromosome 1-22). The following code can be used to combine summary statistic files: 


```bash
head -n 1 /path/to/fastgwa_outputs/fastGWA_c1_dataset.fastGWA > Combined_g_GWAS_dataset_chr1_22.fastGWA

for i in {1..22}; do

    tail -n +2 /path/to/fastgwa_outputs/fastGWA_c${i}_dataset.fastGWA >> Combined_g_GWAS_dataset_chr1_22.fastGWA

done
```

The lambda GC value should fall within the desired range of 1.0-1.4 before the inclusion of principal components and 1.0-1.15 after the inclusion of principal components as covariates.  

Although unlikely, in the case that the lambda GC value exceeds desired thresholds, quality control parameters should be adjusted i.e. made more stringent, until the value falls within normal range.  

__Note__: As we are using a MLM (fastGWA), genomic inflation should already be accounted for through inclusion of the GRM. 

__Note__: PGC dosage marker call files contain variants with an INFO score >0.1 and MAF >0.005, meaning these baseline parameters can be adjusted to ensure the lambda GC values falls within the range.  

INFO scores and frequency metrics can be found in the corresponding .dosage.info files belonging to the original dosage marker outputs. A list of variants failing to exceed the adjusted thresholds can be derived from these files for extraction during re-analysis. Where the lambda GC falls outside the desired range, the association analysis (fastGWA), should be re-run with the –extract function to remove the poor-quality variants.


## Running Lambda GC in Snellius

```bash
module load 2023
module load R/4.3.2-gfbf-2023a   # Check exact version with: module avail R
Rscript -e '
d <- read.table("Combined_g_GWAS_dataset_chr1_22.fastGWA", header=TRUE)
chisq <- qchisq(d$P, df=1, lower.tail=FALSE)
lambda_gc <- median(chisq, na.rm=TRUE) / qchisq(0.5, df=1)
cat("Lambda GC:", lambda_gc, "\n")
'
```
