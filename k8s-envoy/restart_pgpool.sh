#!/bin/sh


LD="$(../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.

kubectl apply -f pgpool-service.yaml
kubectl apply -f pgpool-configmap-$LD.yaml
kubectl delete -f pgpool-deployment-$LD.yaml
kubectl apply -f pgpool-deployment-$LD.yaml

kubectl get deployment pgpool -w
