#!/bin/bash

#-----------------------------------------------------------------------------
#  File name   : prepare_example.sh
#  Author      : Olivier Harismendy (oharismendy@ucsd.edu) 
#  Date        : 12/12/2017
#  Description : download rankinen data and convert to plink format
#----------------------------------------------------------------------------

### set run parameters
export OUTPUT_DIR=/results 

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
mv Jap_endurance_GWAS_Plos_One rankinen
for file in rankinen/*; do mv $file rankinen/rankinen.${file##*.}; done

### convert binary PLINK format to text PLINK format
plink --bfile rankinen/rankinen --recode \
      --out rankinen --noweb




