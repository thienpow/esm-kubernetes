#!/bin/bash


LD="$(../../helper_sh/check_current_cluster.sh)"

#
# destroy or not, you choose
#
while true; do
  clear
  echo "You are now in $LD cluster."
  echo "WARNING!!! pg_master data,pvc,pv will all be destroyed immediately if you proceed."
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
kubectl scale deploy pg-master --replicas=0
kubectl delete pvc postgres-master-pvc

linked_pv=$(kubectl get pv | awk '/postgres-master-pvc/{ print $1 }')
kubectl delete pv $linked_pv

#
# choose a size
#
choice_size=0
while :; do

  if [ "$choice_size" -ge 1 ] && [ "$choice_size" -le 20 ]; then
    break
  else
    echo ""
    echo "_________________________________________________________________________________"
    echo ""
    echo "All data gone.  Now let's recreate the PV/PVC for a fresh new pg-master database."
    echo "Please enter a number for the PV disk size in 'Gi' "
    read -p "(1-100): " choice_size
  fi

done

#
# finally recreating the pvc,pv and restart the pg-master
#
sed -i.bak "s/storage:.*/storage: ${choice_size}Gi/" postgres-master-pvc-$LD.yaml
rm  postgres-master-pvc-$LD.yaml.bak
kubectl apply -f postgres-master-pvc-$LD.yaml
kubectl scale deploy pg-master  --replicas=1