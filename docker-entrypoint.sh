#!/bin/sh

: "${PDNS_local_port:=53}"
: "${PDNS_local_address:=0.0.0.0}"

export PDNS_local_port PDNS_local_address

if [ -f /etc/debian_version ]; then
	config_file=/etc/powerdns/pdns.conf
	pdns_user=root
fi

#/usr/local/bin/envsubst < /etc/dnsdist/dnsdist.conf.tmpl > $config_file

envtpl < /etc/powerdns/pdns.conf.tmpl > $config_file

chown ${pdns_user}: $config_file

exec "$@" 
