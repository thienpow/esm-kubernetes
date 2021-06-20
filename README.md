

# IMPORTANT
must have the following installed:
* docker = brew install docker
* doctl = brew install doctl
* kubectl = brew install kubectl
* certstrap = brew install certstrap
* base64 = brew install base64
* yarn = brew install yarn

#### Generate Personal Access Token at DigitalOcean API menu
```sh
export DIGITALOCEAN_ACCESS_TOKEN=e1b03c02f77eee583d315f83ee664eeee3a893ba6a58213c48cbc409431a30e6
doctl auth init
```


#### Create cluster
* don't really need to create already. because existing one already working.
```sh
doctl k8s cluster create esm-cluster-sgp-01 --region "sgp1" --auto-upgrade --node-pool "name=esmpool;auto-scale=true;min-nodes=1;max-nodes=10"
```


#### Enable access to newly created Cluster.
below are the one already created.
```sh
doctl kubernetes cluster kubeconfig save 471cf60d-b6f2-42fc-965f-4b365dd90bcd # dev cluster
doctl kubernetes cluster kubeconfig save 91e70185-3665-4e51-bf32-f8185f48d1ab # live cluster
```



## Re-build microservices docker images
* configure the export paths in micro/rebuild.sh file
* simply use the micro/rebuild.sh
```sh
cd micro
./rebuild.sh
```

## Re-build database docker images
* simply use the database/certs/rebuild.sh
```sh
cd database/certs
./rebuild.sh
```

# Troubleshooting

* Request for new Certs? must wait for the service ready and got the ExternalIP and then go to DNS to point all the subdomain in this project to that IP.

* can't access to registry from deployment.yaml?
** add secret to allow docker registry access (do one time per cluster only, if already can access, then just ignore)
** usually already did, so can just ignore until creating new Cluster.
```sh
doctl registry kubernetes-manifest | kubectl apply -f -
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-esm-dev"}]}'
```

* if after changing the DNS, flush your local PC too to view the changes
```sh
 sudo killall -HUP mDNSResponder
 ping dev-admin.esportsmini.com -c 1
 ping dev-api.esportsmini.com -c 1
 ping dev-gloader.esportsmini.com -c 1
 ping dev-stripe.esportsmini.com -c 1
```


* Volume id? to check Volume list at DigitalOcean to find out the handler id.
doctl compute volume list

* special cases
# to use existing volume on DigitalOcean
https://github.com/digitalocean/csi-digitalocean/blob/master/examples/kubernetes/pod-single-existing-volume/README.md


# to check database size
```sql
select pg_size_pretty(pg_database_size(current_database()));

select pg_size_pretty(sum(pg_database_size(datname))) from pg_database;
```


# steps to resize pg-master PVC
* don't touch it if you are unsure.
* don't use kubectl delete -f command
* first must stop the pg-master by stopping it in a safe way.
```sh
kubectl scale deploy pg-master  --replicas=0
```
* after stopping it with the command above, resize it via editing postgres-master-pvc-live.yaml (if you are in live cluster) in pg-master folder.
* then,
```sh
kubectl apply -f postgres-master-pvc-live.yaml
```
* then start the pg-master again via
```sh
kubectl scale deploy pg-master  --replicas=1
```
* don't ever try --replicas greater than 1! it will cause permanant locking of the system.

# Or, use the script i written!
* check the k8s-envoy/pg-master/resize_pvc.sh
* to use:
```sh
cd k8s-envoy/pg-master
./resize_pvc.sh
```


# script to deal with pod of pg-master
```sh

# this will retrieve the name of the pod only, no other messy detail
kubectl get pods --selector=app=pg-master | awk 'NR>1{print $1}'

# this will ssh into the pod, short sample
kubectl exec -it <pod_name> -- /bin/sh

# combine the 2 above
kubectl exec -it "$(kubectl get pods --selector=app=pg-master | awk 'NR>1{print $1}')" -- /bin/sh

# check whole disk space without going into the pod. print the detail directly to your local device's terminal
kubectl exec -it "$(kubectl get pods --selector=app=pg-master | awk 'NR>1{print $1}')" -- /bin/df -h

# finally check the PV that bound to /var/lib/postgresql/data
kubectl exec -it "$(kubectl get pods --selector=app=pg-master | awk 'NR>1{print $1}')" -- /bin/df -h | awk 'NR==11{print}'

```

# great scripts to use.

#### resize_pvc, recreate_pvc:
* k8s-envoy/pg-master/resize_pvc.sh 
* k8s-envoy/pg-master/recreate_pvc.sh (it is not recommended to touch... because recreate means destroy existing. )
* k8s-envoy/certbot/recreate_pvc.sh 
* k8s-envoy/pgdumper/recreate_pvc.sh 
* k8s-envoy/pgdumper/resize_pvc.sh 

#### df:
* k8s-envoy/pg-master/df.sh
* k8s-envoy/certbot/df.sh
* k8s-envoy/pgdumper/df.sh

#### rebuild microservices docker images
* micro/rebuild.sh (it has step by step guide)

#### rebuild database and certs
* database/certs/rebuild.sh (it has step by step guide)

#### rsync back the dumps managed by pgdumper
* database/pgdumper/rsync_dumps.sh (this will sync back the dumps folder in pgdumper pod to your local machine)
* database/pgdumper/ls_dumps.sh (this is like the normal ls -l command, but this is for going into the pgdumper pod and ls the dumps folder)