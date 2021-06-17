#!/bin/sh


while true; do
  read -p "You are now in $1 cluster.  Are you sure want to continue? (y/n) : " yn
  case $yn in
    [Yy]* ) 
      break;;
    [Nn]* ) 
      echo 9999
      exit
      ;;
    * ) 
      clear
      echo "Please answer y or n."
      ;;
  esac
done
echo ""
echo "_____________________________________________________________________________________"
echo ""