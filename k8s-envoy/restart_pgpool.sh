#!/bin/sh


LD="$(../helper_sh/check_current_cluster.sh $1)" # auto check and set the value for live or dev cluster.

kubectl apply -f pgpool/pgpool-service.yaml
kubectl apply -f pgpool/pgpool-configmap-$LD.yaml
kubectl apply -f pgpool/pgpool-deployment-$LD.yaml


kubectl rollout restart deployment pgpool