#!/bin/sh
echo ""
echo ""
echo "Regenerate postgres pgpool server.crt server.key server.csr"
read -p "IMPORTANT: just leave all the passphrae empty please. Press enter key to continue."
echo  "_____________________________________________________________________________________"
certstrap request-cert --common-name server --domain pgpool
certstrap sign server --CA ca

mv -f out/server.* ../pgpool
echo  "moved new server.* files to ./../pgpool folder."
echo  "done pgpool"
echo  "_____________________________________________________________________________________"