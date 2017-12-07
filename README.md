# DataMed-Admixture
DataMed Admixture

### Install Docker
Download and install [Docker community edition](https://www.docker.com/community-edition)

### Example Data
Rankinen et al. PLoS One 2016
- No Evidence of a Common DNA Variant Profile Specific to World Class Endurance Athletes
- [Article on PubMed](https://www.ncbi.nlm.nih.gov/pubmed/26824906)
- [Data on Figshare](https://figshare.com/articles/GAMES_discovery_data_sets/1619893)

### Example run
Commands to run an example run with a published data.
Set the absolute path of your own local directory, where output will be created.
```bash
export MY_LOCAL_DIR="/usr/john/myoutput"
docker run -d -v ${MY_LOCAL_DIR}:/examplerun_hapmap3 j5kim/datamed-admixture:latest bash /opt/DataMed-Admixture/example/examplerun_hapmap3.sh
head -n 5 ${OUTPUT_DIR}/output_${PLINK_INPUT_PREFIX}.txt | cut -d ' ' -f 2-
```

Above run is success if you see the 5 lines in the output as below.
```bash
sample YRI CHB CHD TSI MKK LWK CEU JPT
JPN110359 0.0000 0.1725 0.0000 0.0000 0.0000 0.0000 0.0000 0.8275
JPN111073 0.0000 0.1545 0.1091 0.0000 0.0000 0.0000 0.0000 0.7364
JPN111121 0.0000 0.1959 0.0000 0.0000 0.0000 0.0000 0.0000 0.8041
JPN111382 0.0000 0.1682 0.0000 0.0000 0.0000 0.0000 0.0000 0.8318
```
