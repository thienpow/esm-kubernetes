#!/bin/sh


LD=$1

echo ""
echo ""
echo "Regenerate postgres master server.crt server.key server.csr"
read -p "${RED}IMPORTANT${NC}: just leave all the passphrae empty please. Press enter key to continue."
echo  "_____________________________________________________________________________________"
certstrap request-cert --common-name server --domain pg-master
certstrap sign server --CA ca

mv -f out/server.crt ../master/$LD-server.crt
mv -f out/server.csr ../master/$LD-server.csr
mv -f out/server.key ../master/$LD-server.key
echo  "moved new server.* files to ./../master folder."
echo  "done pg-master"
echo  "_____________________________________________________________________________________"