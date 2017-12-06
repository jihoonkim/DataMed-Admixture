### set the base image to Ubuntu
#FROM ubuntu:16.04
FROM rocker/rstudio

### File author / maintainer
MAINTAINER Jihoon Kim "j5kim@ucsd.edu"

### change a working directory to /opt
WORKDIR /opt

### update the repository source list and install dependent packages
RUN apt-get update -y                                            && \
    apt-get install -y git                                       && \
    git clone https://github.com/jihoonkim/DataMed-Admixture.git && \
    Rscript /opt/DataMed-Admixture/provision/install_Rpackages.R && \
    bash /opt/DataMed-Admixture/provision/install_iadmix.sh      && \

### change a working directory to /opt/ancestry
WORKDIR /opt/ancestry
