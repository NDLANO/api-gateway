#!/bin/sh

function prepare_remote {
    secretsfile="/tmp/secrets"
    aws s3 --region eu-central-1 cp s3://$NDLA_ENVIRONMENT.secrets.ndla/api-gateway.secrets $secretsfile

    export KONG_CLUSTER_ADVERTISE=$HOST_IP:7946

    export KONG_PG_HOST=$(cat $secretsfile | jq -r .META_SERVER)
    export KONG_PG_PORT=$(cat $secretsfile | jq -r .META_PORT)
    export KONG_PG_DATABASE=$(cat $secretsfile | jq -r .META_RESOURCE)
    export KONG_PG_USER=$(cat $secretsfile | jq -r .META_USER_NAME)
    export KONG_PG_PASSWORD=$(cat $secretsfile | jq -r .META_PASSWORD)

    rm $secretsfile
}

if [ "$NDLA_ENVIRONMENT" != "local" ]
then
    prepare_remote
fi

export KONG_PROXY_LISTEN=0.0.0.0:80
kong start
