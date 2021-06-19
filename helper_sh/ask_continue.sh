#!/bin/bash

export BOLD=$(tput bold)                         # make colors bold/bright
export RED="$BOLD$(tput setaf 1)"                # bright red text
export NC=$'\e[0m'      

while true; do
  read -p "You are now in ${RED}$1${NC} cluster. Are you sure want to continue? (y/n) : " yn
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