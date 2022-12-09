#!/bin/sh

#[ "$DEBUG" = "true" ] && set -eo pipefail
[ "$DEBUG" = "true" ] && set -x

COMMAND="$@"

# Measure the time it takes to bootstrap the container
START=`date +%s`

echo "grunt process"
grunt clean
grunt exec:breeze-evolution
grunt less:breeze-evolution
grunt watch

END=`date +%s`
RUNTIME=$((END-START))
echo "Startup preparation finished in ${RUNTIME} seconds"