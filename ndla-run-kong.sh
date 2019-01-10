#!/bin/sh

function prepare_remote {
    export KONG_CLUSTER_ADVERTISE=$(hostname -i):7946
}

function setup_logging {
    ## Taken from pull request on docker-kong: https://github.com/Mashape/docker-kong/pull/84/files

    # Make a pipe for the logs so we can ensure Kong logs get directed to docker logging
    # see https://github.com/docker/docker/issues/6880
    # also, https://github.com/docker/docker/issues/31106, https://github.com/docker/docker/issues/31243
    # https://github.com/docker/docker/pull/16468, https://github.com/behance/docker-nginx/pull/51
    rm -f /tmp/logpipe
    mkfifo -m 666 /tmp/logpipe
    # This child process will still receive signals as per https://github.com/Yelp/dumb-init#session-behavior
    cat <> /tmp/logpipe 1>&2 &
}

function setup_nginx_caches {
    if [ $NDLA_ENVIRONMENT == "staging" ] || [ $NDLA_ENVIRONMENT == "prod" ]; then
	    ln -fs /nginx-caches-prod.conf /nginx-caches.conf
    else
        ln -fs /nginx-caches-default.conf /nginx-caches.conf
    fi
}

if [ "$NDLA_ENVIRONMENT" != "local" ]
then
    prepare_remote
fi

setup_logging
setup_nginx_caches

export KONG_PROXY_LISTEN=0.0.0.0:8000
export KONG_ADMIN_LISTEN=0.0.0.0:8001
kong start --nginx-conf /nginx.template
