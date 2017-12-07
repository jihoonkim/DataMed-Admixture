# build a docker container from Dockerfile
docker build -t j5kim/datamed-admixture:latest .

# create an image from a container
MY_DOCKER_TAG=$(docker ps -a -q | head -n 1)
docker commit -a "Jihoon Kim" ${MY_DOCKER_TAG} j5kim/datamed-admixture
  
# log in to docker hub
docker login --username=j5kim 

# push the image into the docker hub
docker push j5kim/datamed-admixture

docker run -t -i -v /Users/jihoonkim/Project/DataMed-Admixture/examplerun_hapmap3:/examplerun_hapmap3 j5kim/datamed-admixture:latest /opt/ancestry/example/examplerun_hapmap3.sh



  
#docker tag ????? j5kim/datamed-admixture:v1
# docker run -t -i -v /Users/jihoonkim/Project/DataMed-Admixture/testrun_hapmap3:/testrun_hapmap3 ubuntu:16.04 /bin/bash

# Actually clean up stopped containers:
docker rm -v $(docker ps -a -q -f status=exited)

# delete dangling images
docker rmi $(docker images -q -f dangling=true)