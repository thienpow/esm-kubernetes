#!/bin/sh
echo ""
echo ""
echo "Regenerate postgres master server.crt server.key server.csr"
read -p "IMPORTANT: just leave all the passphrae empty please. Press enter key to continue."
echo  "_____________________________________________________________________________________"
certstrap request-cert --common-name server --domain pg-master
certstrap sign server --CA ca

mv -f out/server.* ../master
echo  "moved new server.* files to ./../master folder."
echo  "done pg-master"
echo  "_____________________________________________________________________________________"