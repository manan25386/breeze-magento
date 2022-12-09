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

echo "Running upgrade.."
$CMD_MAGENTO se:up

echo "Code compilation"
$CMD_MAGENTO se:di:compile

echo "Give Permission to pub/static"
chmod -R 0777 pub/static/

echo "Give Permission to var and generated"
chmod -R 0777 var/ generated/

echo "Give Permission to pub/media"
chmod -R 0777 pub/media/

END=`date +%s`
RUNTIME=$((END-START))
echo "Startup preparation finished in ${RUNTIME} seconds"
