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
find www/static/js/ -name "*.txt" -type f -delete


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

# prepare the config values to replace.

if [ $LD == "live" ]
then                              # pattern=$1 | folder=$2 | search=$3 | replace=$4
  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" ${DEV_API_ENDPOINT} ${LIVE_API_ENDPOINT}
  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $DEV_STRIPE_KEY $LIVE_STRIPE_KEY

  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $DEV_FIREBASE_API_KEY $LIVE_FIREBASE_API_KEY
  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $DEV_FIREBASE_AUTH_DOMAIN $LIVE_FIREBASE_AUTH_DOMAIN
  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $DEV_FIREBASE_DB_URL $LIVE_FIREBASE_DB_URL
  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $DEV_FIREBASE_PROJECT_ID $LIVE_FIREBASE_PROJECT_ID
  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $DEV_FIREBASE_STORAGE_BUCKET $LIVE_FIREBASE_STORAGE_BUCKET
  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $DEV_FIREBASE_MSG_SENDER_ID $LIVE_FIREBASE_MSG_SENDER_ID
  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $DEV_FIREBASE_APP_ID $LIVE_FIREBASE_APP_ID
  ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $DEV_FIREBASE_MEASURE_ID $LIVE_FIREBASE_MEASURE_ID
else
  if [ $LD == "dev" ]
  then
    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" ${LIVE_API_ENDPOINT} ${DEV_API_ENDPOINT}
    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $LIVE_STRIPE_KEY $DEV_STRIPE_KEY

    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $LIVE_FIREBASE_API_KEY $DEV_FIREBASE_API_KEY
    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $LIVE_FIREBASE_AUTH_DOMAIN $DEV_FIREBASE_AUTH_DOMAIN
    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $LIVE_FIREBASE_DB_URL $DEV_FIREBASE_DB_URL
    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $LIVE_FIREBASE_PROJECT_ID $DEV_FIREBASE_PROJECT_ID
    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $LIVE_FIREBASE_STORAGE_BUCKET $DEV_FIREBASE_STORAGE_BUCKET
    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $LIVE_FIREBASE_MSG_SENDER_ID $DEV_FIREBASE_MSG_SENDER_ID
    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $LIVE_FIREBASE_APP_ID $DEV_FIREBASE_APP_ID
    ../../helper_sh/search_replace.sh "main.*.chunk.js" "www/static/js" $LIVE_FIREBASE_MEASURE_ID $DEV_FIREBASE_MEASURE_ID
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
