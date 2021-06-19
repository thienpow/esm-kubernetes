#!/bin/sh


LD="$(../helper_sh/check_current_cluster.sh $1)" # auto check and set the value for live or dev cluster.

kubectl apply -f pg-standby/postgres-standby-service.yaml
kubectl apply -f pg-standby/postgres-standby-deployment-$LD.yaml

kubectl rollout restart deployment pg-standby