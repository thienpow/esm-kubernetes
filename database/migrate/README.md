use pgAdmin
https://www.pgadmin.org/

check the ipaddress from DigitalOcean->Network->LoadBalancer, get the IP Address of dev-pg-master-lb
connect it via ip address.

Then, back up the whole database to the backup.tar in this folder.

After than, bring down the current pg-master in the dev cluster
and recreate it by applying the pg-master-deployment.yaml, the new database will have tables and some initial data you don't want
so, copy the content of delete_tables.sql and paste it to the Query Tool in pgAdmin, run and delete all the tables.

Finally, restore the database using the backup.tar by using pgAdmin, right click on the postgres database, click Restore... 