# DataMed-Admixture
DataMed Admixture

### Install Docker
Download and install [Docker community edition](https://www.docker.com/community-edition)


### Input 
Input files are genotypes in plink text format (cohortname.ped and cohortname.map) and mapped to GRCh37 human reference genome (no "chr" in chromsome ID). Please refer to [plink](http://zzz.bwh.harvard.edu/plink/) or [plink 1.9](https://www.cog-genomics.org/plink/1.9/) documentation to obtain such files from other formats, including VCF formats 


### Output 
the analysis produces two file names after the input file
* output_cohortname.txt provides the admixture level of each subject for each reference population
* output_summary_cohortname.txt provides the cohort-wide cumulative admixture fraction as well as the diversity score. 


### Example Input Data
In order to test the analysis we provide an accessory scripts 'prepare_example.sh', which downloads a public datasets and reformats it to plink ped and map format

Rankinen et al. PLoS One 2016
- No Evidence of a Common DNA Variant Profile Specific to World Class Endurance Athletes
- [Article on PubMed](https://www.ncbi.nlm.nih.gov/pubmed/26824906)
- [Data on Figshare](https://figshare.com/articles/GAMES_discovery_data_sets/1619893)

### Example run
Commands to run an example run with a published data.
Set the absolute path of your own local directory, where output will be created.

#### Download and Prepare example
run the following set of commands to download the example data and convert them in your 'mydata' directory
```bash
export MY_LOCAL_DIR="/usr/john/mydata"
docker run -d -v ${MY_LOCAL_DIR}:/results j5kim/datamed-admixture:latest bash /opt/DataMed-Admixture/example/prepare_example.sh
```

#### Run the example analysis

call hapmap3 based admixture on the example data by executing the following commands. 

```bash
docker run -d -v ${MY_LOCAL_DIR}:/results j5kim/datamed-admixture:latest bash /opt/DataMed-Admixture/scripts/run_hapmap3.sh /results/rankinen
```
Above run is success if you see the 2 files output.rankinen.txt and output_summary_rankinen.txt

### Run

Provide your data in plink (cohortname.ped and cohortname.map) format and run the following command to call admixture and diversity score from the Hapmap3 reference. 

```bash
export MY_LOCAL_DIR="/usr/john/mydata"
docker run -d -v ${MY_LOCAL_DIR}:/results j5kim/datamed-admixture:latest bash /opt/DataMed-Admixture/scripts/run_hapmap3.sh /results/cohortname
```

