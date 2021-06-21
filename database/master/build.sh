#!/bin/sh


LD="$(../../helper_sh/check_current_cluster.sh $1)" # auto check and set the value for live or dev cluster.

#
# here we build and push to registry
#
image_name="registry.digitalocean.com/esm-dev/${LD}-pg-master"
docker build --rm -t $image_name . -f ${LD}.Dockerfile
docker push $image_name
docker rmi $image_name
