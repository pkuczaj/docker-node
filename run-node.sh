#!/usr/bin/env bash

set -e

LOGDIR="/opt/log/$HOSTNAME"
mkdir -p $LOGDIR
chown john $LOGDIR

# ensure CA bundles are up to date
update-ca-trust force-enable
update-ca-trust extract

cd /node

# Run command for local Dev environments
exec /bin/su -s /bin/sh -c "node . '--WMPropertiesPattern=./config/$ENVIRONMENT/*_config.json'" john

# Run command that's it used in the Kube system
# exec /bin/su -s /bin/sh -c "node . '--WMPropertiesPattern=./config/$ENVIRONMENT/*_config.json' --WMUseSimpleLogger" john >> ${LOGDIR}/uncaught_stdout.log 2>> ${LOGDIR}/uncaught_stderr.log