#!/bin/bash

doctl registry login

LD="$(../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.
clear
while true; do
  read -p "You are now in $LD cluster.  Are you sure want to continue? (y/n) : " yn
  case $yn in
    [Yy]* ) 
      break;;
    [Nn]* ) exit;;
    * ) 
      clear
      echo "Please answer y or n."
      ;;
  esac
done
echo ""
echo "_____________________________________________________________________________________"
echo ""



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


