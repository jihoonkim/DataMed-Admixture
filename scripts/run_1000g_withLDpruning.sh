#!/bin/bash

#-----------------------------------------------------------------------------
#  File name   : run_1000g_withLDpruning.sh
#  Author      : Olivier Harismendy (oharismendy@ucsd.edu)
#  Date        : 4/23/2018
#  Description : run input data with 1KG superpopulations as a reference
#----------------------------------------------------------------------------

### set run parameters
export OUTPUT_DIR=/results 
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/1000Gphase3.5superpopulations.hg19.withLDpruning.txt
export INPUT_DATA=$1


### create an output directory if not exists
mkdir -p ${OUTPUT_DIR}

### extract basename from inputfile name
name=`basename ${INPUT_DATA}`

### estimate the global admixture proportion of known reference populations
python ${iADMIX_DIR}/runancestry.py  --freq=${RESOURCE_DATA}  \
    --path=${iADMIX_DIR} --plink=${INPUT_DATA} \
    --out=${OUTPUT_DIR}/${name}

### aggregate individual estimates into a single output file
echo  -ne "reference sample " > ${OUTPUT_DIR}/output_${name}.txt
head -n 1 ${RESOURCE_DATA} | cut -d ' ' -f 6-  >>  ${OUTPUT_DIR}/output_${name}.txt
grep -w "final maxval" ${OUTPUT_DIR}/*.input.ancestry | \
  awk -F ':' '{split($1,a,"."); print a[1],a[2], $3,$4,$5,$6,$7}' | \
  cut -d ' ' -f1,2,3,5,7,9,11  >> ${OUTPUT_DIR}/output_${name}.txt


### calculate the diversity score for the cohort 
Rscript /opt/DataMed-Admixture/scripts/getDivScore.R ${OUTPUT_DIR}/output_${name}.txt > ${OUTPUT_DIR}/output_summary_${name}.txt 2>${OUTPUT_DIR}/R.log

### cleaning up
rm -rf ${OUTPUT_DIR}/${name}*.input 
rm -rf ${OUTPUT_DIR}/${name}*.input.ancestry 
