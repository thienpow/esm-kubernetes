#!/bin/sh


LD="$(../helper_sh/check_current_cluster.sh)"
[[ "$(../helper_sh/ask_continue.sh ${LD})" =~ 9999 ]] && exit

kubectl apply -f frontenvoy-configmap-$LD.yaml
kubectl delete -f frontenvoy-deployment.yaml
kubectl apply -f frontenvoy-deployment.yaml