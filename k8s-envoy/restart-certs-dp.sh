#!/bin/sh


# if new postgres ca cert is regenerated, need to run this restart-certs-dp.sh to restart all the linked deployments.

LD="$(../helper_sh/check_current_cluster.sh $1)" # auto check and set the value for live or dev cluster.

kubectl apply -f pg-ca-secret-$LD.yaml

./restart_all_pg.sh $1

kubectl apply -f gloader/esm-game-loader-deployment-$LD.yaml
kubectl apply -f service/esmservice-deployment-$LD.yaml
kubectl apply -f checkers/checkers-deployment-$LD.yaml

kubectl rollout restart deployment esmservice
kubectl rollout restart deployment esm-game-loader
kubectl rollout restart deployment checkers
