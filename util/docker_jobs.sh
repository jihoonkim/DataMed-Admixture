# clean up stopped containers:
docker rm -v $(docker ps -a -q -f status=exited)

# delete dangling images
docker rmi $(docker images -q -f dangling=true)

# build a docker container from Dockerfile
docker build -t j5kim/datamed-admixture .

# test run docker
export MY_LOCAL_DIR=/Users/jihoonkim/Project/DataMed-Admixture/examplerun_hapmap3
docker run -t -i -v ${MY_LOCAL_DIR}:/examplerun_hapmap3 j5kim/datamed-admixture:latest /opt/DataMed-Admixture/example/examplerun_hapmap3.sh

# create an image from a container
MY_DOCKER_TAG=$(docker ps -a -q | head -n 1)
docker commit -a "Jihoon Kim" ${MY_DOCKER_TAG} j5kim/datamed-admixture
  
# log in to docker hub
docker login --username=j5kim 


# tag a local image with ID "some hash number" into a repository
#docker tag j5kim/datamed-admixture j5kim/datamed-admixture:v1

# push the image into the docker hub
docker push j5kim/datamed-admixture



#--------------------------------------------------------------------------
# miscellaneous docker commands
#--------------------------------------------------------------------------
#docker tag 5kim/datamed-admixture j5kim/datamed-admixture:v1

# Actually clean up stopped containers:
docker rm -v $(docker ps -a -q -f status=exited)

# delete dangling images
docker rmi $(docker images -q -f dangling=true)
