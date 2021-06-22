#!/bin/sh


#
# check if this script was started with an argv passed in. expecting live or dev
#
LD="$(../../helper_sh/check_current_cluster.sh $1)"

#
# here we build and push to registry
#
image_name="registry.digitalocean.com/esm-dev/${LD}-service"
docker build --rm -t $image_name .
docker push $image_name
docker rmi $image_name


#
# restart the deployment in kubernetes
#
kubectl apply  -f "../../k8s-envoy/service/esmservice-deployment-${LD}.yaml"
kubectl rollout restart deployment esmservice