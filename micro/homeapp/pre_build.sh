#!/bin/sh


ORIGIN_FOLDER=${PWD}


if [ ! -d $ESM_HOMEAPP_SOURCE_FOLDER ] 
then
    echo "Directory ESM_HOMEAPP_SOURCE_FOLDER DOES NOT exists." 
    exit 9999 # die with error code 9999
fi

cd $ESM_HOMEAPP_SOURCE_FOLDER
#echo "I am in... ${PWD}"
SOURCE_FOLDER=${PWD}/build/*


echo ""
echo ""
while true; do
  read -p "Do you want to do git pull and yarn build on the [ homeapp ] source code? (y/n) : " yn
  case $yn in
    [Yy]* ) 
      rm .eslintcache
      git pull
      yarn build
      break;;
    [Nn]* ) break;;
    * ) 
      echo "Please answer y or n."
      ;;
  esac
done


# cd back to homeapp folder
cd $ORIGIN_FOLDER
#echo "I am in... ${PWD}"
TARGET_FOLDER=${PWD}/www

rm -rf $TARGET_FOLDER
rsync -av $SOURCE_FOLDER $TARGET_FOLDER