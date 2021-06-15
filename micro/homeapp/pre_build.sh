#!/bin/bash


cd "../../../../FrontEnd/esportsmini"
#echo "I am in... ${PWD}"
SOURCE_FOLDER=${PWD}/build/*

npm run build

# cd back to homeapp folder
cd "../../BackEnd/kubernetes/micro/homeapp"
#echo "I am in... ${PWD}"
TARGET_FOLDER=${PWD}/www

rm -rf $TARGET_FOLDER
rsync -av $SOURCE_FOLDER $TARGET_FOLDER