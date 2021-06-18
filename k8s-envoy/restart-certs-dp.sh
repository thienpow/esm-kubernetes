#!/bin/sh

# if new postgres ca cert is regenerated, need to run this apply-certs.sh to restart all the linked deployments.

LD="$(../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.

kubectl apply -f pg-ca-secret-$LD.yaml


kubectl apply -f pgpool/pgpool-configmap-$LD.yaml
kubectl apply -f pgpool/pgpool-deployment-$LD.yaml
kubectl apply -f pg-standby/postgres-standby-deployment-$LD.yaml
kubectl apply -f gloader/esm-game-loader-deployment-$LD.yaml
kubectl apply -f service/esmservice-deployment-$LD.yaml
kubectl apply -f checkers/checkers-deployment-$LD.yaml

kubectl rollout restart deployment pg-master
kubectl rollout restart deployment pg-standby
kubectl rollout restart deployment pgpool
kubectl rollout restart deployment esmservice
kubectl rollout restart deployment esm-game-loader
kubectl rollout restart deployment checkers
