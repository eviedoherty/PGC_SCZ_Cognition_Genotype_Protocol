Please note, this step is only applicable if you have collapsed datasets (See __Data Preparation__)

# Dosage Marker Calls 

The __03_merge_all_dataset_chrs.sh__ script should be applied to datasets that have undergone collapsing as per the __Data Preparation__ section. This will allow you to concatenate the dosage marker calls for the collapsed datasets. The outputs from the __02_dosage_combine_per_chr.sh__ script should be used as inputs for the __03_merge_all_dataset_chrs.sh__ script. 

 

This script requires the use of QCTOOL (Band, 2021) which can be downloaded from: https://github.com/gavinband/qctool. This is not available as a module on Snellius and therefore will need to be loaded into your project from the GitHub repository. 

 

__Note__: the concatenation function is not yet available through PLINK2 and when attempted with –pmerge, will flag the following error message: ‘Non-concatenating --pmerge[-list] is under development', hence the use of QCTOOL.   
