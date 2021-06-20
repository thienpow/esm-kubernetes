#!/bin/sh


pod_name="$(kubectl get pods --selector=app=pgdumper | awk 'NR==2{print $1}')"
kubectl exec -it $pod_name -- /bin/ls /dumps -l
