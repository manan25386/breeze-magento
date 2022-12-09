#!/bin/bash
# export $(xargs <global.env)
[ "$DEBUG" = "true" ] && set -x
# echo $DB_BKP_PATH
# echo $MYSQL_USER
# echo $MYSQL_PASSWORD
# echo $MYSQL_DATABASE

MYSQL_DATABASE=alramauae
MYSQL_USER=root
MYSQL_PASSWORD=server
DB_BKP_PATH=./db/alramauae.sql

set -x
args="$@"
bash -c "cat $DB_BKP_PATH | docker-compose exec -T db /usr/bin/mysql -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE"
echo "Done"
