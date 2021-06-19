#!/bin/sh


export BOLD=$(tput bold)                         # make colors bold/bright
export RED="$BOLD$(tput setaf 1)"                # bright red text
export NC=$'\e[0m'      


doctl registry login

LD="$(../../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.
[[ "$(../../helper_sh/ask_continue.sh ${LD})" =~ 9999 ]] && exit

rm -rf out
echo ""
echo ""
echo "Regenerate All certs for postgres"
read -p "${RED}IMPORTANT${NC}: just leave all the passphrae empty please. Press enter key to continue."
echo  "_____________________________________________________________________________________"
certstrap init --common-name ca

cp -f out/ca.crl out/ca.crt ./../master
cp -f out/ca.crl out/ca.crt ./../standby
cp -f out/ca.crl out/ca.crt ./../pgpool
echo  "copied new ca.crl and ca.crt to ./../master ./../standby and ./../pgpool folder."

#
# backup the ca key/cert
#
cp -f out/ca.key ./../backup/$LD-ca.key
cp -f out/ca.crl ./../backup/$LD-ca.crl
cp -f out/ca.crt ./../backup/$LD-ca.crt

base64Value=$(base64 out/ca.crt)
# echo $base64Value
sed "s/ca_token_here/$base64Value/g" pg-ca-secret-template.yaml > pg-ca-secret-$LD.yaml
cp pg-ca-secret-$LD.yaml ./../../k8s-envoy/

echo "./../../k8s-envoy/pg-ca-secret-${LD}.yaml is replaced with new ca.crt value"
echo  "done ca"
echo  "_____________________________________________________________________________________"

./regen_master.sh $LD
./regen_standby.sh $LD
./regen_pgpool.sh $LD

#
# rebuild the docker images and push to registry
#
cd ./../master
./build.sh $LD
cd ./../standby
./build.sh $LD
cd ./../pgpool
./build.sh $LD


#
# apply all the changes to Kubernetes
#
cd ./../../k8s-envoy
./restart-certs-dp.sh $LD


#
# clean up
#
rm -rf out