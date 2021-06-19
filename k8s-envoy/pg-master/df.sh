#!/bin/sh


pod_name="$(kubectl get pods --selector=app=pg-master | awk 'NR>1{print $1}')"
kubectl exec -it $pod_name -- /bin/df -h
echo ""
echo ""
echo ""
kubectl exec -it $pod_name -- /bin/df -h | awk 'NR==10{print} NR==11{print $1,$2,$3,$4,$5}'
