#!/bin/bash

#-----------------------------------------------------------------------------
#  File name   : run_1000g.sh
#  Author      : Olivier Harismendy (oharismendy@ucsd.edu)
#  Date        : 12/14/2017
#  Description : run input data with 1KG superpopulations as a reference
#----------------------------------------------------------------------------

### set run parameters
export OUTPUT_DIR=/results 
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/1000Gphase3.5superpopulations.hg19.tsv.gz
export INPUT_DATA=$1

### slices the reference
awk '{print $1,$4}' ${INPUT_DATA}.map | sort -k1,1n -k2,2n | tabix -T - ${RESOURCE_DATA} > ${iADMIX_DIR}/slice.txt

### create an output directory if not exists
mkdir -p ${OUTPUT_DIR}

### extract basename from inputfile name
name=`basename ${INPUT_DATA}`

### estimate the global admixture proportion of known reference populations
python ${iADMIX_DIR}/runancestry.py  --freq=${iADMIX_DIR}/slice.txt --cores=2 \
    --path=${iADMIX_DIR} --plink=${INPUT_DATA} \
    --out=${OUTPUT_DIR}/${name}

### aggregate individual estimates into a single output file
echo  -ne "reference sample " > ${OUTPUT_DIR}/output_${name}.txt
head -n 1 $RESOURCE_DATA | cut -d ' ' -f 6-  >>  ${OUTPUT_DIR}/output_${name}.txt
grep -w "final maxval" ${OUTPUT_DIR}/*.input.ancestry | \
  awk -F ':' '{split($1,a,"."); print a[1],a[2], $3,$4,$5,$6,$7,$8,$9,$10}' | \
  cut -d ' ' -f1,2,3,5,7,9,11,13,15,17  >> ${OUTPUT_DIR}/output_${name}.txt


### calculate the diversity score for the cohort 
Rscript ${iADMIX_DIR}/getDivScore.R ${OUTPUT_DIR}/output_${name}.txt > ${OUTPUT_DIR}/output_summary_${name}.txt 2>${OUTPUT_DIR}/R.log

### cleaning up
rm -rf ${OUTPUT_DIR}/${name}* 


