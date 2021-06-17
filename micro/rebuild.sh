#!/bin/sh

#
# modify the export paths below to the right one on your device
#
export ESM_ADMIN_SOURCE_FOLDER="/users/thienpow/development/esm/frontend/esm-admin"
export ESM_HOMEAPP_SOURCE_FOLDER="/users/thienpow/development/esm/frontend/esportsmini"


if [ ! -d $ESM_ADMIN_SOURCE_FOLDER ] 
then
    echo "Directory ESM_ADMIN_SOURCE_FOLDER DOES NOT exists." 
    exit
fi

if [ ! -d $ESM_HOMEAPP_SOURCE_FOLDER ] 
then
    echo "Directory ESM_HOMEAPP_SOURCE_FOLDER DOES NOT exists." 
    exit
fi


doctl registry login

LD="$(../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.
[[ "$(../helper_sh/ask_continue.sh ${LD})" =~ 9999 ]] && exit


while :; do

  if test -z "$choice"; then
    read -p "Rebuild: All(0), admin(1), homeapp(2), checkers(3), gloader(4), service(5), stripe(6)" choice
  fi
  
  if [ "$choice" -ge 0 ] && [ "$choice" -le 6 ]; then
    break
  else
    read -p "Rebuild: All(0), admin(1), homeapp(2), checkers(3), gloader(4), service(5), stripe(6)" choice
  fi

done


micro_path=${PWD} # keep the current path value so that we can come back to it.
case $choice in
0)
    
  cd $micro_path/admin
  ./build.sh $LD

  cd $micro_path/homeapp
  ./build.sh $LD

  cd $micro_path/checkers
  ./build.sh $LD

  cd $micro_path/gloader
  ./build.sh $LD

  cd $micro_path/service
  ./build.sh $LD

  cd $micro_path/stripe
  ./build.sh $LD

  ;;
1)
  cd $micro_path/admin
  ./build.sh $LD
  ;;
2)
  cd $micro_path/homeapp
  ./build.sh $LD
  ;;
3)
  cd $micro_path/checkers
  ./build.sh $LD
  ;;
4)
  cd $micro_path/gloader
  ./build.sh $LD
  ;;
5)
  cd $micro_path/service
  ./build.sh $LD
  ;;
6)
  cd $micro_path/stripe
  ./build.sh $LD
  ;;
esac


