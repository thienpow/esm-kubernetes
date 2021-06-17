#!/bin/sh


LD="$(../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.

kubectl delete -f esm-homeapp-deployment-$LD.yaml
kubectl apply -f esm-homeapp-deployment-$LD.yaml