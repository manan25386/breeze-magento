#!/bin/sh

#[ "$DEBUG" = "true" ] && set -eo pipefail
[ "$DEBUG" = "true" ] && set -x

COMMAND="$@"

# Measure the time it takes to bootstrap the container
START=`date +%s`

echo "Download Nodejs.."
curl -fsSL https://deb.nodesource.com/setup_14.x | bash -

echo "Install Node"
apt-get install -y nodejs

echo "Configure Grunt"
npm install -g grunt-cli
npm install
npm update

END=`date +%s`
RUNTIME=$((END-START))
echo "Startup preparation finished in ${RUNTIME} seconds"
