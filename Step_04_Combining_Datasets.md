Please note, this step is only applicable if you have collapsed datasets (See __Data Preparation__)

__Hard Calls__ 

__Step 1__: Match phenotype IDs to genotype IDs using the available .fam files and generate a .txt file containing the matching IDs. Please note that this is a general guide, and individual approaches to ID matching is permitted.   

__IMPORTANT__: Anything in __red__ should be adjusted to match your path/file names.  

 

__Scenario 1 - Phenotype IDs fully match genotype IDs in the IID/FID column__ 

The below code matches the phenotype IDs to the genotype IID column (column 2 .fam file; $2).  

If the phenotype IDs match the FID column (column 1 .fam file), adjust the code accordingly (adjust “$2 in ids” to “$1 in ids”): 

