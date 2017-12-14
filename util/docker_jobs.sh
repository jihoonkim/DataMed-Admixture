#-----------------------------------------------------------------------------
#  File name   : docker_jobs.sh
#  Author      : Jihoon Kim (j5kim@ucsd.edu)
#  Date        : 12/13/2017
#  Description : A collection of useful commands to build a Docker image
#-----------------------------------------------------------------------------

# clean up stopped containers:
docker rm -v $(docker ps -a -q -f status=exited)

# delete dangling images
docker rmi $(docker images -q -f dangling=true)

# build a docker container from Dockerfile
docker build -t j5kim/datamed-admixture .

# prepare an example 
export MY_LOCAL_DIR=/Users/jihoonkim/Project/DataMed-Admixture/testout
docker run -d -v ${MY_LOCAL_DIR}:/results j5kim/datamed-admixture:latest bash /opt/DataMed-Admixture/example/prepare_example.sh


# test run docker
docker run -d -v ${MY_LOCAL_DIR}:/results j5kim/datamed-admixture:latest bash /opt/DataMed-Admixture/scripts/run_hapmap3.sh /results/rankinen

# create an image from a container
MY_DOCKER_TAG=$(docker ps -a -q | head -n 1)
docker commit -a "Jihoon Kim" ${MY_DOCKER_TAG} j5kim/datamed-admixture
  
# log in to docker hub
docker login --username=j5kim 

# tag a local image with ID "some hash number" into a repository
#docker tag j5kim/datamed-admixture j5kim/datamed-admixture:v1

# push the image into the docker hub
docker push j5kim/datamed-admixture
