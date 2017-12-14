#!/usr/bin/env sh

patch /usr/sbin/amavisd /etc/ndocker/clean_stdout_log.patch

sa-update -v

busybox syslogd -n -O /dev/stdout &
bb_pid=$!

crond -f &
cron_pid=$!

consul-template -config /etc/ndocker/amavisd.hcl &
amavis_pid=$!

trap "kill $bb_pid $cron_pid $amavis_pid" INT TERM
wait $amavis_pid
