#!/bin/sh

function is_kubernetes {
    [ -e "/var/run/secrets/kubernetes.io" ]
}

function setup_nginx_caches {
    if [ "$NDLA_ENVIRONMENT" == "staging" ] || [ "$NDLA_ENVIRONMENT" == "prod" ]
    then
	ln -fs /nginx-caches-prod.conf /nginx-caches.conf
    else
        ln -fs /nginx-caches-default.conf /nginx-caches.conf
    fi
}

function setup_dns_resolver {
    if is_kubernetes; then # Check whether we are running on kubernetes or not
        echo "resolver kube-dns.kube-system.svc.cluster.local;" > /nginx-resolver.conf
    else
        echo "resolver 127.0.0.11;" > /nginx-resolver.conf
    fi
}

setup_nginx_caches
setup_dns_resolver

export KONG_CLUSTER_ADVERTISE=$(hostname -i):7946
export KONG_PROXY_LISTEN=0.0.0.0:8000
export KONG_ADMIN_LISTEN=0.0.0.0:8001

kong start --nginx-conf /nginx.template
