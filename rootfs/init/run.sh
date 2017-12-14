#!/usr/bin/env sh

patch /usr/sbin/amavisd /etc/ndocker/clean_stdout_log.patch

sa-update -v

busybox syslogd -n -O /dev/stdout &
bbchild=$!

consul-template -config /etc/ndocker/amavisd.hcl &
child=$!

trap "kill $bbchild $child" INT TERM
wait $child
