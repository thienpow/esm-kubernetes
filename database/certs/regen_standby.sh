#!/bin/sh


LD=$1

echo ""
echo ""
echo "Regenerate postgres standby server.crt server.key server.csr"
read -p "${RED}IMPORTANT${NC}: just leave all the passphrae empty please. Press enter key to continue."
echo  "_____________________________________________________________________________________"
certstrap request-cert --common-name server --domain pg-standby
certstrap sign server --CA ca

mv -f out/server.crt ../standby/$LD-server.crt
mv -f out/server.csr ../standby/$LD-server.csr
mv -f out/server.key ../standby/$LD-server.key
echo  "moved new server.* files to ./../standby folder."
echo  "done pg-standby"
echo  "_____________________________________________________________________________________"