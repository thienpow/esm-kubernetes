#!/bin/bash


cd "../../../../FrontEnd/esm-admin" # this is esm-admin source code folder
#echo "I am in... ${PWD}"
SOURCE_FOLDER=${PWD}/www/*

npm run build

# cd back to kubernetes/micro/admin folder 
cd "../../BackEnd/kubernetes/micro/admin"
#echo "I am in... ${PWD}"
TARGET_FOLDER=${PWD}/www

rm -rf $TARGET_FOLDER
rsync -av $SOURCE_FOLDER $TARGET_FOLDER