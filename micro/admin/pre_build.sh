#!/bin/bash


ORIGIN_FOLDER=${PWD}


if [ ! -d $ESM_ADMIN_SOURCE_FOLDER ] 
then
    echo "Directory ESM_ADMIN_SOURCE_FOLDER DOES NOT exists." 
    exit 9999 # die with error code 9999
fi

cd $ESM_ADMIN_SOURCE_FOLDER # this is esm-admin source code folder
#echo "I am in... ${PWD}"
SOURCE_FOLDER=${PWD}/www/*

while true; do
  read -p "Do you want to do git pull and npm run build on the source code? (y/n) : " yn
  case $yn in
    [Yy]* ) 
      git pull
      npm run build
      break;;
    [Nn]* ) break;;
    * ) 
      echo "Please answer y or n."
      ;;
  esac
done


# cd back to kubernetes/micro/admin folder 
cd $ORIGIN_FOLDER
#echo "I am in... ${PWD}"
TARGET_FOLDER=${PWD}/www

rm -rf $TARGET_FOLDER
rsync -av $SOURCE_FOLDER $TARGET_FOLDER