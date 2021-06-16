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
find www/static/css/ -name "*.map" -type f -delete
find www/static/js/ -name "*.map" -type f -delete


#
# start modifying content of html
#
search="\/static"
replace="https:\/\/esm-cdn.sgp1.cdn.digitaloceanspaces.com\/app\/${LD}\/static"
folder="www"
../../helper_sh/search_replace.sh "index.html" $folder $search $replace
../../helper_sh/search_replace.sh "asset-manifest.json" $folder $search $replace


#
# edit the js first
#
if [ $LD == "live" ]
then                              # pattern=$1 | folder=$2 | search=$3 | replace=$4
  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" "https:\/\/dev-" "https:\/\/live-"
else
  if [ $LD == "dev" ]
  then                              # pattern=$1 | folder=$2 | search=$3 | replace=$4
    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" "https:\/\/live-" "https:\/\/dev-"
  fi
fi

#
# upload files to Spaces
#
do_spaces_folder="s3://esm-cdn/app/"

input_file="www/static/css/*"
s3cmd put $input_file "${do_spaces_folder}${LD}/static/css/"

input_file="www/static/js/*"
s3cmd put $input_file "${do_spaces_folder}${LD}/static/js/"
# after all uploaded, make the whole folder to public accessible.
s3cmd setacl "${do_spaces_folder}${LD}/static/" --acl-public --recursive


#
# here we build and push to registry
#
image_name="registry.digitalocean.com/esm-dev/${LD}-homeapp"
docker build --rm -t $image_name .
docker push $image_name
docker rmi $image_name


#
# restart the deployment in kubernetes
#
kubectl delete -f "../../k8s-envoy/esm-homeapp-deployment-${LD}.yaml"
kubectl apply  -f "../../k8s-envoy/esm-homeapp-deployment-${LD}.yaml"
kubectl get deployment esm-homeapp -w
