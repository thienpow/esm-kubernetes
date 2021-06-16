# IMPORTANT!!!

don't simply run certs/rebuild.sh for fun.
make sure you know what it does in the script

* it will regenerate the CA certs and Server certs for pg-master and pg-standby
* it will rebuild the image and push it to the registry automatically 
* at the end and re-apply all the yaml files related to the self-signed cert.

if you don't understand what it do, ask first please.
