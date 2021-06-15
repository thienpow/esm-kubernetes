

# IMPORTANT
must have the following installed:
* docker = brew install docker
* doctl = brew install doctl
* kubectl = brew install kubectl
* certstrap = brew install certstrap
* base64 = brew install base64


#### Generate Personal Access Token at DigitalOcean API menu
```sh
export DIGITALOCEAN_ACCESS_TOKEN=e1b03c02f77eee583d315f83ee664eeee3a893ba6a58213c48cbc409431a30e6
doctl auth init
```


#### Create cluster
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