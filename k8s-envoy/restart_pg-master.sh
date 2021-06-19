#!/bin/sh


LD="$(../helper_sh/check_current_cluster.sh $1)" # auto check and set the value for live or dev cluster.

kubectl apply -f pg-master/postgres-master-service.yaml
kubectl apply -f pg-master/postgres-master-deployment-$LD.yaml

kubectl rollout restart deployment pg-master

BOLD=$(tput bold)                         # make colors bold/bright
RED="$BOLD$(tput setaf 1)"                # bright red text
NC=$'\e[0m'      

clear
echo ""
echo "${RED}IMPORTANT${NC}: Pleae read!!!"
echo "_______________________________________________________________________"
echo ""
echo "Please watch and wait the pg-master's pod is recreated and running."
echo "You will see it shows Terminating->Pending->ContainerCreating->Running."
echo "Press CRTL+C to continue when the STATUS shows Running."
echo "_______________________________________________________________________"
echo ""
kubectl get pods --selector=app=pg-master -w