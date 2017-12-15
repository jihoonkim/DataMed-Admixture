
#!/bin/bash

#-----------------------------------------------------------------------------
#  File name   : install_iadmix.sh
#  Author      : Jihoon Kim (j5kim@ucsd.edu), Olivier Harismendy
#  Date        : 12/14/2017
#  Description : Install iAdmix to calculate population allele frequency
#                for an input vcf-format file.
#-----------------------------------------------------------------------------

### update the repository source list 
apt-get update -y 

### install dependent packages
apt-get install -y autoconf build-essential curl gcc-multilib git g++ \
 libbz2-dev liblzma-dev libncurses5-dev libssl-dev libz-dev make pkg-config  \
 software-properties-common python wget zip zlibc zlib1g zlib1g-dev tabix

### install iADMIX to compute population allele frequencies
cd /opt 
git clone https://github.com/vibansal/ancestry.git
cd ancestry
find . -type f -name '*.o' -delete # recursively delete all *.o files 
make all

### install vcftools to convert .vcf to PLINK format file
cd /opt
git clone https://github.com/vcftools/vcftools.git 
cd vcftools
./autogen.sh 
./configure 
make 
make install

### install PLINK
cd /opt
wget http://zzz.bwh.harvard.edu/plink/dist/plink-1.07-x86_64.zip
unzip plink-1.07-x86_64.zip
ln -s /opt/plink-1.07-x86_64/plink /usr/local/bin/plink 

### download resource data, the population allele frequencies for common SNPs
###  of the International HapMap Project
cd /opt/ancestry
wget "https://ndownloader.figshare.com/files/9920605" -O hapmap3.8populations.hg19.txt.zip
unzip hapmap3.8populations.hg19.txt.zip
rm hapmap3.8populations.hg19.txt.zip

### download resource data, the population allele frequencies for common SNPs
###  of the 1000 Genomes Project
cd /opt/ancestry
wget "https://ndownloader.figshare.com/files/10001002" -O 1000Gphase3.5superpopulations.hg19.tsv.gz
