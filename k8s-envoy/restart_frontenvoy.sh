#!/bin/sh


LD="$(../helper_sh/check_current_cluster.sh $1)"
[[ "$(../helper_sh/ask_continue.sh ${LD})" =~ 9999 ]] && exit

kubectl apply -f frontenvoy-configmap-$LD.yaml
kubectl apply -f frontenvoy-deployment.yaml

kubectl rollout restart deployment frontenvoy