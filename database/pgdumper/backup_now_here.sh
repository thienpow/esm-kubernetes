#!/bin/sh


BACKUP_DIR=dumps/
EXPIRED_DAYS=90 #`expr $((($WEEKS_TO_KEEP * 7) + 1))`
SUFFIX=".sql.gz"

if [ -d "$BACKUP_DIR" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo ""
else
  mkdir $BACKUP_DIR
fi

# Delete all expired weekly directories
find $BACKUP_DIR -maxdepth 1 -mtime +$EXPIRED_DAYS -type f -delete
pod_name="$(kubectl get pods --selector=app=pg-standby | awk 'NR==2{print $1}')"
kubectl exec -it $pod_name -- /usr/local/bin/pg_dump -U doadmin postgres | gzip -9 > $BACKUP_DIR"`date +\%Y-\%m-\%d`"$SUFFIX
