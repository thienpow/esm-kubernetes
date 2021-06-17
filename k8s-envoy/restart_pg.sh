#!/bin/sh


LD="$(../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.

kubectl apply -f pgpool-service.yaml
kubectl apply -f postgres-standby-service.yaml
kubectl apply -f postgres-master-service.yaml

kubectl delete -f pgpool-deployment-$LD.yaml
kubectl delete -f postgres-standby-deployment-$LD.yaml
kubectl delete -f postgres-master-deployment-$LD.yaml

kubectl get deployment pg-master -w
kubectl apply -f postgres-standby-deployment-$LD.yaml
kubectl get deployment pg-standby -w
kubectl apply -f pgpool-deployment-$LD.yaml


#kubectl apply -f postgres-master-deployment-$LD.yaml
echo "postgres-master-deployment-${LD}.yaml is not applied.  "
echo "Reason: you need to manually check and wait for the existing pg-master already down and removed from Deployment. "
echo "Don't rush to apply it because it will cause a 2 pg-master trying to access to the Volume and stuck with a deadlock postmaster.pid"
read -p "Press any key to start watching the pg-master status"
kubectl get deployment pg-master -w
