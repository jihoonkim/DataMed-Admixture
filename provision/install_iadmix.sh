
#!/bin/bash

#-----------------------------------------------------------------------------
#  File name   : install_iadmix.sh
#  Author      : Jihoon Kim (j5kim@ucsd.edu)
#  Date        : 12/5/2017
#  Description : Install iAdmix to calculate population allele frequency
#                for an input vcf-format file.
#-----------------------------------------------------------------------------

### update the repository source list 
apt-get update -y 

### install dependent packages
apt-get install -y  autoconf build-essential curl git g++ libncurses5-dev \
 libssl-dev make pkg-config software-properties-common python vim \
 wget zip zlibc zlib1g zlib1g-dev 

### install iADMIX to compute population allele frequencies
cd /opt 
git clone https://github.com/vibansal/ancestry.git
cd ancestry
make all

### install vcftools to convert .vcf to PLINK format file
cd /opt
git clone https://github.com/vcftools/vcftools.git 
cd vcftools
./autogen.sh 
./configure 
make 
make install

### download resource data, the population allele frequencies for common SNPs
###  of the International HapMap and 1000 Genomes Projects
cd /opt/ancestry
wget "https://ndownloader.figshare.com/files/9920605" -O hapmap3.8populations.hg19.txt.zip
unzip hapmap3.8populations.hg19.txt.zip
rm hapmap3.8populations.hg19.txt.zip

wget "https://ndownloader.figshare.com/files/9920560" -O 1000Gphase3.5superpopulations.hg19.txt.zip
unzip 1000Gphase3.5superpopulations.hg19.txt.zip
rm 1000Gphase3.5superpopulations.hg19.txt.zip