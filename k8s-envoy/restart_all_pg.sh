#!/bin/sh


LD="$(../helper_sh/check_current_cluster.sh $1)" # auto check and set the value for live or dev cluster.

./restart_pg-master.sh $LD

wait_time=60
echo "Wait for another ${wait_time} seconds"
echo ""
temp_cnt=${wait_time}
while [[ ${temp_cnt} -gt 0 ]];
do
    printf "\rYou have %2d second(s) remaining!" ${temp_cnt}
    sleep 1
    ((temp_cnt--))
done

./restart_pg-standby.sh $LD
./restart_pgpool.sh $LD
