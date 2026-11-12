# Main Association Analysis 

## Autosomal Variants 

The association analysis for each dataset should be performed using the GCTA mixed linear model, fastGWA (Jiang et al., 2019). FastGWA uses a genetic relationship matrix (GRM) to account for population stratification and correct for genetic relatedness in the sample. Due to the continuous nature of ‘g’, a linear model association analysis should be performed. 


__Download GCTA__ 

The version of GCTA available on Snellius has a bug, hindering the generation of the GRM. Therefore, the newest version of GCTA was downloaded from the following link: https://yanglab.westlake.edu.cn/software/gcta/bin/gcta-1.95.3-linux-x86_64.zip. 

__Note__: Both wget and curl failed to download GCTA directly on to Snellius as direct downloading from the Westlake University site (GCTA download site) to Snellius was blocked. Therefore, GCTA was downloaded to a local device as a .zip file and subsequently uploaded to Snellius for use.  
