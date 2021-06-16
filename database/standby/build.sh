#!/bin/sh


LD="$(../../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.


#
# here we build and push to registry
#
image_name="registry.digitalocean.com/esm-dev/${LD}-pg-standby"
docker build --rm -t $image_name .
docker push $image_name
docker rmi $image_name
