#!/bin/bash
#input_file="www/static/css/*"
#s3cmd put $input_file s3://esm-cdn/app/dev/static/css/
#input_file="www/static/js/*"
#s3cmd put $input_file s3://esm-cdn/app/dev/static/js/
#s3cmd setacl s3://esm-cdn/app/dev/static/ --acl-public --recursive


#pattern="main.*.chunk.js"
#folder="www/static/js"

#main_file="$(find $folder -type f -iname $pattern)"
#echo $main_file

#liveDev="dev"
#if [ $liveDev == "live" ]
#then
#  echo "yes"
#fi

cluster_result="$(kubectl get nodes)"
#echo $cluster_result

if echo "$cluster_result" | grep -q "dev-pool"; then
    echo "D";
else
  if echo "$cluster_result" | grep -q "live-pool"; then
    echo "L";
  fi
fi