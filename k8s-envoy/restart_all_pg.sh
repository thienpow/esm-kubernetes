#!/bin/sh


LD="$(../helper_sh/check_current_cluster.sh $1)" # auto check and set the value for live or dev cluster.
#[[ "$(../helper_sh/ask_continue.sh ${LD})" =~ 9999 ]] && exit

./restart_pg-master.sh $LD
./restart_pg-standby.sh $LD
./restart_pgpool.sh $LD
