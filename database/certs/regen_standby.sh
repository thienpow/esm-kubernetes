#!/bin/bash
echo ""
echo ""
echo "Regenerate postgres standby server.crt server.key server.csr"
read -p "IMPORTANT: just leave all the passphrae empty please. Press enter key to continue."
echo  "_____________________________________________________________________________________"
certstrap request-cert --common-name server --domain pg-standby
certstrap sign server --CA ca

mv -f out/server.* ../standby
echo  "moved new server.* files to ./../standby folder."
echo  "done pg-standby"
echo  "_____________________________________________________________________________________"