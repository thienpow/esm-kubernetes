

#### Generate Personal Access Token at DigitalOcean API menu
```sh
export DIGITALOCEAN_ACCESS_TOKEN=e1b03c02f77eee583d315f83ee664eeee3a893ba6a58213c48cbc409431a30e6
doctl auth init
doctl k8s cluster create esm-cluster-sgp-01 --region "sgp1" --auto-upgrade --node-pool "name=esmpool;auto-scale=true;min-nodes=1;max-nodes=10"
```

#### Enable access to newly created Cluster.
```sh
doctl kubernetes cluster kubeconfig save 471cf60d-b6f2-42fc-965f-4b365dd90bcd # dev cluster

doctl kubernetes cluster kubeconfig save 91e70185-3665-4e51-bf32-f8185f48d1ab # live cluster
```



## Build docker
* simply use the micro-services/buildall.sh
```sh
cd micro-services
./buildall.sh
```

#### must wait for the service ready and got the ExternalIP and then go to DNS to point all the subdomain in this project to that IP.


# add secret to allow docker registry access (do one time per cluster only, if already can access, then just ignore)
# usually already did, so can just ignore until creating new Cluster.
doctl registry kubernetes-manifest | kubectl apply -f -
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-esm-dev"}]}'



###### if after changing the DNS, flush your local PC too to view the changes
 sudo killall -HUP mDNSResponder
 ping dev-admin.esportsmini.com -c 1
 ping dev-api.esportsmini.com -c 1
 ping dev-gloader.esportsmini.com -c 1
 ping dev-stripe.esportsmini.com -c 1



# to check Volume list at DigitalOcean to find out the handler id.
doctl compute volume list
# to use existing volume on DigitalOcean
https://github.com/digitalocean/csi-digitalocean/blob/master/examples/kubernetes/pod-single-existing-volume/README.md

# to database size
```sql
select pg_size_pretty(pg_database_size(current_database()));

select pg_size_pretty(sum(pg_database_size(datname))) from pg_database;
```