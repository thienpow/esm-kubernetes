#!/bin/bash

# if new postgres ca cert is regenerated, need to run this apply-certs.sh to restart all the linked deployments.

LD="$(../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.

kubectl apply -f pg-ca-secret-$LD.yaml

kubectl delete -f postgres-master-deployment-$LD.yaml
kubectl delete -f postgres-standby-deployment-$LD.yaml
kubectl delete -f esm-game-loader-deployment-$LD.yaml
kubectl delete -f esmservice-deployment-$LD.yaml
kubectl delete -f checkers-deployment-$LD.yaml

kubectl apply -f postgres-master-deployment-$LD.yaml
kubectl apply -f postgres-standby-deployment-$LD.yaml
kubectl apply -f esm-game-loader-deployment-$LD.yaml
kubectl apply -f esmservice-deployment-$LD.yaml
kubectl apply -f checkers-deployment-$LD.yaml