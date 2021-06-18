#!/bin/sh

# if new postgres ca cert is regenerated, need to run this apply-certs.sh to restart all the linked deployments.

LD="$(../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.

kubectl delete -f pg-ca-secret-$LD.yaml
kubectl apply -f pg-ca-secret-$LD.yaml


kubectl delete -f pgpool-deployment-$LD.yaml
kubectl delete -f postgres-master-deployment-$LD.yaml
kubectl delete -f postgres-standby-deployment-$LD.yaml
kubectl delete -f esm-game-loader-deployment-$LD.yaml
kubectl delete -f esmservice-deployment-$LD.yaml
kubectl delete -f checkers-deployment-$LD.yaml


kubectl apply -f pgpool-configmap-$LD.yaml
kubectl apply -f pgpool-deployment-$LD.yaml
kubectl apply -f postgres-standby-deployment-$LD.yaml
kubectl apply -f esm-game-loader-deployment-$LD.yaml
kubectl apply -f esmservice-deployment-$LD.yaml
kubectl apply -f checkers-deployment-$LD.yaml


#kubectl apply -f postgres-master-deployment-$LD.yaml
echo "postgres-master-deployment-${LD}.yaml is not applied.  "
echo "Reason: you need to manually check and wait for the existing pg-master already down and removed from Deployment. "
echo "Don't rush to apply it because it will cause a 2 pg-master trying to access to the Volume and stuck with a deadlock postmaster.pid"
read -p "Press any key to start watching the pg-master status"
kubectl get deployment pg-master -w
kubectl get pods | grep pg-master
read -p "if you still can see a pg-master pod is running after the kubectl get pods above. try manually kill that first."