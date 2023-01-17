FROM debian:latest
MAINTAINER "atanas argirov" <atanas@argirov.org>

# install gnupg2, curl & sqlite3
RUN apt update && apt install -y gnupg2 curl sqlite3 python3-pip

# add powerdns repo
COPY apt.pdns.repo /etc/apt/sources.list.d/pdns.list
COPY apt.pdns.pref /etc/apt/preferences.d/pdns 
RUN curl https://repo.powerdns.com/CBC8B383-pub.asc | apt-key add -  
# update repo
RUN apt update && apt install --no-install-recommends -y pdns-server pdns-backend-lmdb pdns-backend-sqlite3 pdns-backend-lua2 pdns-backend-pgsql pdns-backend-bind pdns-tools 
RUN pip install envtpl

EXPOSE 53/tcp 53/udp

COPY pdns.conf.tmpl /etc/powerdns/pdns.conf.tmpl
COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "/usr/sbin/pdns_server", "--config-dir=/etc/powerdns","--guardian=no", "--daemon=no", "--disable-syslog", "--log-timestamp=no", "--write-pid=no" ]
