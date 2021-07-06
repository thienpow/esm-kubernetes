#!/bin/bash


RESIZE_THRESHOLD=70 #if current disk usage is greater than the RESIZE_THRESHOLD, then it will add extra 5Gi minimum to the resize.


if [ $# -eq 0 ]
then 
  size_to_resize=0
  echo "You did not specify a number to resize"
else 
  size_to_resize=$1 
fi

LD="$(../../helper_sh/check_current_cluster.sh)"
[[ "$(../../helper_sh/ask_continue.sh ${LD})" =~ 9999 ]] && exit

storage=$(cat pgdumper-pvc.yaml | grep "storage:"  | awk -F ": " '{print $2}')
value=$(echo $storage | sed -e "s/Gi//g")
read -p "Current pgdumper-pvc.yaml storage: value is: $storage"

pod_name="$(kubectl get pods --selector=app=pgdumper | awk 'NR>1{print $1}')"
actual=$(kubectl exec -it $pod_name -- /bin/df -h | awk 'NR==6{print $1,$2,$3,$4,$5}')
echo "Current Actual PVC df result is: "
echo $actual

usage_percent=$(echo $actual | awk '{print $4}')
usage_percent=$(echo $usage_percent | sed -e "s/%//g")

if test $usage_percent -gt $RESIZE_THRESHOLD
then
  echo ">${RESIZE_THRESHOLD}% disk space used, should resize."
  extra=$(($value + 5)) #recommended to add 1Gi
  if test $extra -gt $size_to_resize #check if the user specified size to add is actually more than the recommended 1Gi
  then
    $size_to_resize=$extra #if user specified is lesser, use the 1Gi recommendation.
  fi
else
  echo "Disk space still ok, $usage_percent% used."
fi


if test $size_to_resize -gt $value
then
  read -p "Press any key to continue to resize now to ${size_to_resize}Gi.  Or, CTRL+C to cancel."
  sed -i.bak "s/storage:.*/storage: $size_to_resizeGi/" pgdumper-pvc.yaml
  rm pgdumper-pvc.yaml.bak
  kubectl apply -f pgdumper-pvc.yaml
  kubectl rollout restart deployment pgdumper
else
  echo "Specified value to resize is smaller than existing.  Please specify a bigger size."
fi
