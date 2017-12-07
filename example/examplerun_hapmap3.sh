#!/bin/bash

#-----------------------------------------------------------------------------
#  File name   : examplerun_hapmap3.sh
#  Author      : Jihoon Kim (j5kim@ucsd.edu)
#  Date        : 12/5/2017
#  Description : run example data with HapMap3 as a reference
#----------------------------------------------------------------------------

### set run parameters
export PLINK_INPUT_PREFIX=Japanese_Endurance
export OUTPUT_DIR=/examplerun_hapmap3 
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/hapmap3.8populations.hg19.txt

### create an output directory if not exists
mkdir -p ${OUTPUT_DIR}

### download an example input data
###  Rankinen et al. PLoS One 2016
###  No Evidence of a Common DNA Variant Profile Specific to World Class Endurance Athletes
###  https://www.ncbi.nlm.nih.gov/pubmed/26824906
###  https://figshare.com/articles/GAMES_discovery_data_sets/1619893
cd ${OUTPUT_DIR}
wget "https://ndownloader.figshare.com/files/3573941" -O Jap_endurance_GWAS_Plos_One.zip
unzip Jap_endurance_GWAS_Plos_One.zip

### convert binary PLINK format to text PLINK format
plink --bfile Jap_endurance_GWAS_Plos_One/Japanese_Endurance --recode \
      --out Japanese_Endurance --noweb

### estimate the global admixture proportion of known reference populations
python ${iADMIX_DIR}/runancestry.py  --freq=${RESOURCE_DATA} --cores=2 \
    --path=${iADMIX_DIR} --plink=${PLINK_INPUT_PREFIX} \
    --out=${OUTPUT_DIR}/${PLINK_INPUT_PREFIX} 

### aggregate individual estimates into a single output file
echo  -ne "reference sample " > ${OUTPUT_DIR}/output_${PLINK_INPUT_PREFIX}.txt
head -n 1 $RESOURCE_DATA | cut -d ' ' -f 6-  >>  ${OUTPUT_DIR}/output_${PLINK_INPUT_PREFIX}.txt
grep -w "final maxval" ${OUTPUT_DIR}/*.input.ancestry | \
  awk -F ':' '{split($1,a,"."); print a[1],a[2], $3,$4,$5,$6,$7,$8,$9,$10}' | \
  cut -d ' ' -f1,2,3,5,7,9,11,13,15,17  >> ${OUTPUT_DIR}/output_${PLINK_INPUT_PREFIX}.txt

### check the example run output.
### 'run is success if you see the first 5 lines (except the first column)
head -n 5 ${OUTPUT_DIR}/output_${PLINK_INPUT_PREFIX}.txt | cut -d ' ' -f 2-
# sample YRI CHB CHD TSI MKK LWK CEU JPT
# JPN110359 0.0000 0.1725 0.0000 0.0000 0.0000 0.0000 0.0000 0.8275
# JPN111073 0.0000 0.1545 0.1091 0.0000 0.0000 0.0000 0.0000 0.7364
# JPN111121 0.0000 0.1959 0.0000 0.0000 0.0000 0.0000 0.0000 0.8041
# JPN111382 0.0000 0.1682 0.0000 0.0000 0.0000 0.0000 0.0000 0.8318



