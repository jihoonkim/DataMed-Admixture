#!/bin/bash

#-----------------------------------------------------------------------------
#  File name   : examplerun_1000g.sh
#  Author      : Jihoon Kim (j5kim@ucsd.edu)
#  Date        : 12/5/2017
#  Description : run example data with 1000 Genomes as a reference
#----------------------------------------------------------------------------

### set run parameters
export PLINK_INPUT_PREFIX=Japanese_Endurance
export OUTPUT_DIR=/examplerun_1000g
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/1000Gphase3.5superpopulations.hg19.txt

### create an output directory if not exists
mkdir -p ${OUTPUT_DIR}

### download an example input data
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
### 'run is success if md5 value of the first 10 lines is 0d718bff9e06ae2e9e9d4c9ffe9206d0
head -n 10 ${OUTPUT_DIR}/output_${PLINK_INPUT_PREFIX}.txt
head -n 10 ${OUTPUT_DIR}/output_${PLINK_INPUT_PREFIX}.txt | md5sum 