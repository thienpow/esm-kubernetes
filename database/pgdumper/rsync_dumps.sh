#!/bin/sh

LD="$(../../helper_sh/check_current_cluster.sh)"

pod_name="$(kubectl get pods --selector=app=pgdumper | awk 'NR==2{print $1}')"
./krsync.sh -av --progress --stats $pod_name:/dumps/ ./$LD-dumps