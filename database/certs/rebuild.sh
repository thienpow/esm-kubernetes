#!/bin/sh

doctl registry login

LD="$(../../helper_sh/check_current_cluster.sh)" # auto check and set the value for live or dev cluster.
[[ "$(../../helper_sh/ask_continue.sh ${LD})" =~ 9999 ]] && exit

rm -rf out
echo ""
echo ""
echo "Regenerate All certs for postgres"
read -p "IMPORTANT: just leave all the passphrae empty please. Press enter key to continue."
echo  "_____________________________________________________________________________________"
certstrap init --common-name ca

cp -f out/ca.crl out/ca.crt ./../master
cp -f out/ca.crl out/ca.crt ./../standby
echo  "copied new ca.crl and ca.crt to ./../master ./../standby folder."

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

echo "./../../k8s-envoy/pg-ca-secret.yaml is replaced with new ca.crt value"
echo  "done ca"
echo  "_____________________________________________________________________________________"

./regen_master.sh
./regen_standby.sh

#
# rebuild the docker images and push to registry
#
cd ./../master
./build.sh
cd ./../standby
./build.sh


#
# apply all the changes to Kubernetes
#
cd ./../../k8s-envoy
./apply-certs.sh


#
# clean up
#
rm -rf out