# Main Association Analysis 

## Autosomal Variants 

The association analysis for each dataset should be performed using the GCTA mixed linear model, fastGWA (Jiang et al., 2019). FastGWA uses a genetic relationship matrix (GRM) to account for population stratification and correct for genetic relatedness in the sample. Due to the continuous nature of ‘g’, a linear model association analysis should be performed. 


## Download GCTA

The version of GCTA available on Snellius has a bug, hindering the generation of the GRM. Therefore, the newest version of GCTA was downloaded from the following link: https://yanglab.westlake.edu.cn/software/gcta/bin/gcta-1.95.3-linux-x86_64.zip. 

__Note__: Both wget and curl failed to download GCTA directly on to Snellius as direct downloading from the Westlake University site (GCTA download site) to Snellius was blocked. Therefore, GCTA was downloaded to a local device as a .zip file and subsequently uploaded to Snellius for use.  

__Identify path once uploaded__

```bash
cd /home/your_directory_containing_gcta/gcta-1.95.3-linux-x86_64
./gcta --appimage-extract
ls squashfs-root/    # This should be present in the .zip file
ls squashfs-root/usr/bin/
```

__To use GCTA__

The path identified using the code above should be used when running GCTA. It will likely resemble the example below, although the exact path may vary. 

```bash
./squashfs-root/usr/bin/gcta64
```

## Creating the GRM 

The GRM should be generated for each dataset using a subset of high-quality variants with light pruning applied. Please note that the GRM was generated using the full sample available for each dataset to ensure it can be used for analyses beyond the current project. 

The CEU HapMap3 variants were used to derive a subset of common and reliably genotyped variants. HapMap3 SNP lists can be downloaded from the following link: https://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/hapmap3_r3/plink_format/hapmap3_r3_b36_fwd.qc.poly.tar.gz 

__Step 1 - Generate a usable SNP list__


```bash
awk '{print $2}' hapmap3_r2_b36_fwd.qc.poly/hapmap3_r3_b36_fwd.CEU.qc.poly.map > hapmap3_CEU.snplist
```

__Step 2 - Extract the high-quality variants from the merged dosage files per chromosome__

```bash
for chr in {1..22} 
do 
    plink2 \ 
        --bgen /path/to/per/chr/files/chr${chr}_merged.bgen ref-first \ 
        --sample /path/to/per/chr/files/chr${chr}_merged.sample \ 
        --indep-pairwise 1000 100 0.9 \ 
        --extract /path/to/snplist/hapmap3_CEU.snplist \ 
        --rm-dup force-first \ 
        --out /path/for/output/file/chr${chr}_prune 
done
```

__Step 3 - Extract pruned variants__

```bash
for chr in {1..22} 
do 
plink2 \ 
  --bgen /path/to/per/chr/files/chr${chr}_merged.bgen ref-first \ 
  --sample /path/to/per/chr/files/chr${chr}_merged.sample \ 
  --extract chr${chr}_prune.prune.in \ 
  --make-bed \ 
  --out chr${chr}_pruned_for_fastGWA 
done 
```

__Step 4 - Merge the per chromosome pruned variants before generating the GRM partitions__  

The following code uses PLINK 1.9 to merge the per chromosome pruned bfiles. PLINK 1.9 was uploaded to Snellius using wget and the following link https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20260927.zip  


__Generate .txt file of bfiles to merge__

```bash
for chr in {1..22}; do
    echo "/path/to/pruned/files/chr${chr}_pruned_for_fastGWA"
done > /path/for/output/file/pruned_files_dataset.txt
```

__Run merge__ 

```bash
/path/to/plink \    #plink 1.9 
  --merge-list /path/to/pruned/files/merge/list/pruned_files_dataset.txt \ 
  --make-bed \ 
  --out /path/to/combined/pruned/files/combined_pruned_for_fastGWA 
```

__Step 5 - Generate GRM partitions__ 

The GRM can be generated in several partitions using the __make_grm_partitions_fastgwa.sh__ script.  


To verify that the partitions have been generated successfully, run the following code to check that the output files contain data. An output of 0 indicates that the partitions have not been generated successfully: 

```bash
ls -la grm_fastgwa_test.part_20_10.grm.N.bin 
```
 
__Note__: By default, the script generates the GRM in 20 partitions. The number of partitions can be adjusted according to sample size, using approximately 1 partition per 100 individuals (e.g. 100 individuals = 1 partition; 250 individuals = 3 partitions). 


__Step 6 - Concatenate GRM partitions__

Once all the partitions have been created, they should be concatenated into a single file using the __concat_for_sparse_grm.sh script__ 

 
__Step 7 - Generate a Sparse GRM__  

The sparse GRM can subsequently be generated using the __make_sparse_grm.sh script__.  


Please ensure to adjust all scripts accordingly to match your data file names/paths. 
