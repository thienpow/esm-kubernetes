#!/bin/sh


LD=$1

echo ""
echo ""
echo "Regenerate postgres pgpool server.crt server.key server.csr"
echo  "_____________________________________________________________________________________"
certstrap request-cert --passphrase='' --common-name server --domain pgpool
certstrap sign server --CA ca

mv -f out/server.crt ../pgpool/$LD-server.crt
mv -f out/server.csr ../pgpool/$LD-server.csr
mv -f out/server.key ../pgpool/$LD-server.key
echo  "moved new server.* files to ./../pgpool folder."
echo  "done pgpool"
echo  "_____________________________________________________________________________________"