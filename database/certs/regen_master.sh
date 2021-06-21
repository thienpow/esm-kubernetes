#!/bin/sh


LD=$1

echo ""
echo ""
echo "Regenerate postgres master server.crt server.key server.csr"
echo  "_____________________________________________________________________________________"
certstrap request-cert --passphrase='' --common-name server --domain pg-master
certstrap sign server --CA ca

mv -f out/server.crt ../master/$LD-server.crt
mv -f out/server.csr ../master/$LD-server.csr
mv -f out/server.key ../master/$LD-server.key
echo  "moved new server.* files to ./../master folder."
echo  "done pg-master"
echo  "_____________________________________________________________________________________"