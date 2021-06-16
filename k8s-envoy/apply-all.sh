#!/bin/sh
wait_time=60 # seconds

LD="$(../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.

kubectl apply -f do-secret.yaml
kubectl apply -f pg-ca-secret-$LD.yaml

echo "creating persistent volumes"
# enable csi for pvc first
# Do *not* add a blank space after -f
kubectl apply -fhttps://raw.githubusercontent.com/digitalocean/csi-digitalocean/master/deploy/kubernetes/releases/csi-digitalocean-v2.1.1/{crds.yaml,driver.yaml,snapshot-controller.yaml}

# here is our pvc
kubectl apply -f certbot-pvc.yaml
kubectl apply -f certbot-pv-$LD.yaml
kubectl apply -f postgres-master-pvc.yaml
kubectl apply -f postgres-master-pv-$LD.yaml

# ***** IMPORTANT *****
# don't rust to next step, until you see the pvc is ready in DigitalOcean's Volume menu. 
# or DigitalOcean's Kubernete Dashboard (click into the  cluster, then click "Kubernete Dashboard" button from cluster Dashboard)

# database first
echo "creating pg-master, pg-standby, pg-pool"
kubectl apply -f postgres-master-service.yaml
kubectl apply -f postgres-master-deployment-$LD.yaml
# go to Kubernetes Dashboard, Pod menu, look for the newly created pg-master-xxx in the list, go for the right side drop down menu, choose log,
# also if it's in "red eye" icon, click on the icon to see what's the error message. usually it's because of the required resources is not ready and you rushed to this step.
echo "Wait for pg-master to be Ready."
echo "check if the pg-master is Ready, if yes, then press CTRL+C one time to continue."
kubectl get deployment pg-master -w

# wait for pg-master is ready and online before going for pg-standby
kubectl apply -f postgres-standby-service.yaml
kubectl apply -f postgres-standby-deployment.yaml
kubectl apply -f pgpool-configmap-$LD.yaml
kubectl apply -f pgpool-service.yaml
kubectl apply -f pgpool-deployment-$LD.yaml

# then other micro-services
echo "creating micro-services"
kubectl apply -f frontenvoy-service.yaml
echo "STOP!!! do not do the following yet, wait for the External IP Address of frontenvoy."
echo "Check DigitalOcean -> Networking -> Load Balancers or wait below until you see the Pending changed to an IP"
# Check DigitalOcean -> Networking -> Load Balancers, rename the new loadbalancer name to something like live-frontenvoy-sgp1
kubectl get services frontenvoy -w

kubectl apply -f certbot-service.yaml
kubectl apply -f esm-admin-service.yaml
kubectl apply -f esm-homeapp-service.yaml
kubectl apply -f esm-game-loader-service.yaml
kubectl apply -f esm-stripe-service.yaml
kubectl apply -f esmservice-service.yaml
kubectl apply -f grpc-web-proxy-service.yaml

kubectl apply -f esm-admin-deployment-$LD.yaml
kubectl apply -f esm-homeapp-deployment-$LD.yaml
kubectl apply -f esm-game-loader-deployment-$LD.yaml
kubectl apply -f esm-stripe-deployment-$LD.yaml
kubectl apply -f esmservice-deployment-$LD.yaml
kubectl apply -f grpc-web-proxy-configmap.yaml
kubectl apply -f grpc-web-proxy-deployment.yaml
kubectl apply -f checkers-deployment-$LD.yaml


kubectl apply -f frontenvoy-configmap-$LD-nocert.yaml
kubectl apply -f frontenvoy-deployment-nocert.yaml

echo "Wait for frontenvoy (nocert) to be Ready, before staring certbot"
echo "***** check if frontenvoy is ready *****, if yes, press CTRL+C one time to continue."
kubectl get deployment frontenvoy -w

kubectl apply -f certbot-deployment-$LD.yaml

echo "Wait for certbot to be Ready, before staring frontenvoy that's serving with cert."
echo ""
temp_cnt=${wait_time}
while [[ ${temp_cnt} -gt 0 ]];
do
    printf "\rYou have %2d second(s) remaining!" ${temp_cnt}
    sleep 1
    ((temp_cnt--))
done
echo "check if the certbot is Ready, if yes, then press CTRL+C one time to continue."
kubectl get deployment certbot -w

# stop first
kubectl delete -f frontenvoy-deployment-nocert.yaml
# start again
kubectl apply -f frontenvoy-configmap-$LD.yaml
kubectl apply -f frontenvoy-deployment.yaml