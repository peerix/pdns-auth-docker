PowerDNS auth server container based on Debian latest

## Run

```shell
docker run -d \
        --name pdns \
        --restart=always \
        -p 127.0.0.1:53:53/udp \
        -p 127.0.0.1:8082:8082/udp \
        -e PDNS_local_address=0.0.0.0 \
        -e PDNS_local_port=53 \
        -e PDNS_loglevel=4 \
        -e PDNS_webserver_address=127.0.0.1 \
        -e PDNS_webserver_port=8081 \
        -e PDNS_webserver_password=<password> \
        -e PDNS_api_key=<api_key> \
        -e PDNS_launch=gpgsql \
        -e PDNS_gpgsql_host=<db_ip> \
        -e PDNS_gpgsql_user=<db_user> \
        -e PDNS_gpgsql_password=<db_password> \
        -e PDNS_gpgsql_dbname=<db> \
        peerix/pdns-auth

```
