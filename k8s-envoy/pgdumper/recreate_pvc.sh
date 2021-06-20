#!/bin/bash


LD="$(../../helper_sh/check_current_cluster.sh)"

#
# destroy or not, you choose
#
while true; do
  clear
  echo "You are now in $LD cluster."
  echo "WARNING!!! cerbot pvc,pv will all be destroyed immediately if you proceed."
  read -p "Are you sure want to continue? (Yes I am in my right mind/n) : " yn
  case $yn in
    ("Yes I am in my right mind") 
      break;;
    [Nn]* ) 
      echo 9999
      exit
      ;;
    * ) 
      clear
      echo "Please answer y or n."
      ;;
  esac
done

#
# no turning back, you already decided
#
kubectl scale deploy pgdumper --replicas=0
kubectl delete pvc pgdumper-pvc

linked_pv=$(kubectl get pv | awk '/pgdumper-pvc/{ print $1 }')
kubectl delete pv $linked_pv

#
# choose a size, pgdumper don't need much size, 1Gi is much more than enough.
#
choice_size=1

#
# finally recreating the pvc,pv and restart the pgdumper
#
sed -i.bak "s/storage:.*/storage: ${choice_size}Gi/" pgdumper-pvc.yaml
rm pgdumper-pvc.yaml.bak
kubectl apply -f pgdumper-pvc.yaml
kubectl scale deploy pgdumper --replicas=1