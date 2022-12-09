#!/bin/sh

#[ "$DEBUG" = "true" ] && set -eo pipefail
[ "$DEBUG" = "true" ] && set -x

COMMAND="$@"

# Measure the time it takes to bootstrap the container
START=`date +%s`

# Set the base Magento command to bin/magento
CMD_MAGENTO="bin/magento" && chmod +x $CMD_MAGENTO

echo "Working Directory"
pwd

echo "Cache Clean"
$CMD_MAGENTO c:c

echo "Compose Install"
php composer.phar install

echo "Running upgrade.."
$CMD_MAGENTO se:up

echo "Set Production Mode"
$CMD_MAGENTO deploy:mode:set production --skip-compilation

echo "Code compilation"
$CMD_MAGENTO se:di:compile

echo "Deploying static content"
$CMD_MAGENTO se:s:d

echo "Cache Clean"
$CMD_MAGENTO c:c

echo "Cache Flush"
$CMD_MAGENTO c:f

echo "Give Permission to pub/static"
chmod -R 0777 pub/static/

echo "Give Permission to var and generated"
chmod -R 0777 var/ generated/

echo "Give Permission to pub/media"
chmod -R 0777 pub/media/

#echo "Give Permission to vendor"
#chmod -R 0777 vendor/

echo "Give Permission to var log import folder"
chmod -R 0777 pub/media/log/import/


echo "Give Permission to var log import folder"
chmod -R 0777 var/log/import/

END=`date +%s`
RUNTIME=$((END-START))
echo "Startup preparation finished in ${RUNTIME} seconds"
