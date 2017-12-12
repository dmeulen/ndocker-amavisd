#!/usr/bin/env sh

busybox syslogd -n -O /dev/stdout &
bbchild=$!

consul-template -config /etc/ndocker/amavisd.hcl &
child=$!

trap "kill $bbchild $child" INT TERM
wait $child
