#!/bin/sh

#
# check if this script was started with an argv passed in. expecting live or dev
#
LD="$(../../helper_sh/check_current_cluster.sh $1)"


#
# call pre_build to build the source code and sync the files to this folder.
#
./pre_build.sh


#
# remove all the map files first, don't put map files to public.
#
find www/css/ -name "*.map" -type f -delete
find www/js/ -name "*.map" -type f -delete


#
# start modifying content of js/html
#
if [ $LD == "live" ]
then                                      # pattern=$1 | folder=$2 | search=$3 | replace=$4
  ../../helper_sh/search_replace.sh "app.*.js" "www/js" "https:\/\/dev-" "https:\/\/live-"
else
  if [ $LD == "dev" ]
  then                                     # pattern=$1 | folder=$2 | search=$3 | replace=$4
    ../../helper_sh/search_replace.sh "app.*.js" "www/js" "https:\/\/live-" "https:\/\/dev-"
  fi
fi


#
# here we build and push to registry
#
image_name="registry.digitalocean.com/esm-dev/${LD}-admin"
docker build --rm -t $image_name .
docker push $image_name
docker rmi $image_name


#
# restart the deployment in kubernetes
#

kubectl apply  -f "../../k8s-envoy/admin/esm-admin-deployment-${LD}.yaml"
kubectl rollout restart deployment esm-admin