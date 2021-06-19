#!/bin/sh


export BOLD=$(tput bold)                         # make colors bold/bright
export RED="$BOLD$(tput setaf 1)"                # bright red text
export NC=$'\e[0m'      

#
# modify the export values below to the right one on your deployment
#
export ESM_ADMIN_SOURCE_FOLDER="/users/thienpow/development/esm/frontend/esm-admin"
export ESM_HOMEAPP_SOURCE_FOLDER="/users/thienpow/development/esm/frontend/esportsmini"

export DEV_API_ENDPOINT="https:\/\/dev-api.esportsmini.com"
export LIVE_API_ENDPOINT="https:\/\/live-api.esportsmini.com"

export DEV_STRIPE_KEY="pk_test_51IOa7gBGCaV2oEVpYi9nxhSEx2tspaZAQdC5aoCgNxGJhr6BxtAnBpk1V4KuXkysmyW1QpPFVJggbRJ0L4eQdVJ30032h0Rlu9"
export LIVE_STRIPE_KEY="pk_test_51IOa7gBGCaV2oEVpYi9nxhSEx2tspaZAQdC5aoCgNxGJhr6BxtAnBpk1V4KuXkysmyW1QpPFVJggbRJ0L4eQdVJ30032h0Rlu9"

export DEV_FIREBASE_API_KEY="AIzaSyCm8agS4fK_yPGGVsGAuohxjMZCpSnBTOs"
export LIVE_FIREBASE_API_KEY="AIzaSyCm8agS4fK_yPGGVsGAuohxjMZCpSnBTOs"

export DEV_FIREBASE_AUTH_DOMAIN="esports-mini.firebaseapp.com"
export LIVE_FIREBASE_AUTH_DOMAIN="esports-mini.firebaseapp.com"

export DEV_FIREBASE_DB_URL="https:\/\/esports-mini.firebaseio.com"
export LIVE_FIREBASE_DB_URL="https:\/\/esports-mini.firebaseio.com"

export DEV_FIREBASE_PROJECT_ID="esports-mini"
export LIVE_FIREBASE_PROJECT_ID="esports-mini"

export DEV_FIREBASE_STORAGE_BUCKET="esports-mini.appspot.com"
export LIVE_FIREBASE_STORAGE_BUCKET="esports-mini.appspot.com"

export DEV_FIREBASE_MSG_SENDER_ID="881527222867"
export LIVE_FIREBASE_MSG_SENDER_ID="881527222867"

export DEV_FIREBASE_APP_ID="1:881527222867:web:bade3c851f83866ab40ca6"
export LIVE_FIREBASE_APP_ID="1:881527222867:web:bade3c851f83866ab40ca6"

export DEV_FIREBASE_MEASURE_ID="G-CB3EDVN8SG"
export LIVE_FIREBASE_MEASURE_ID="G-CB3EDVN8SG"



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


