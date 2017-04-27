#!/usr/bin/env bash

set -e

LOGDIR="/opt/log/$HOSTNAME"
mkdir -p $LOGDIR
chown john $LOGDIR

# ensure CA bundles are up to date
update-ca-trust force-enable
update-ca-trust extract

exec /bin/su -s /bin/sh -c "/usr/bin/node $*" john >> ${LOGDIR}/uncaught_stdout.log 2>> ${LOGDIR}/uncaught_stderr.log
