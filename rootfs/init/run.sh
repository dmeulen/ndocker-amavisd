#!/usr/bin/env sh

# set defaults
export AMAVIS_MYDOMAIN="${AMAVIS_MYDOMAIN:=example.com}"
export AMAVIS_MYHOSTNAME="${AMAVIS_MYHOSTNAME:=amavis.example.com}"
export AMAVIS_MYNETWORKS="${AMAVIS_MYNETWORKS:=127.0.0.0/8 [::1] [FE80::]/10 [FEC0::]/10 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16}"
export AMAVIS_ACL="${AMAVIS_ACL:=192.168.1.1}"
export POSTFIX_RETURN="${POSTFIX_RETURN:=smtp:[192.168.1.100]:10025}"
export CONSUL_SA_USER_PREFS="${CONSUL_SA_USER_PREFS:=false}"

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
