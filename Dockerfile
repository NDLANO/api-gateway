FROM kong:2.0.2-alpine

USER root

COPY ndla-run-kong.sh /ndla-run-kong.sh
COPY nginx.template /nginx.template
COPY nginx-caches-prod.conf nginx-caches-default.conf /
COPY nginx-api-cache.conf /nginx-api-cache.conf
RUN chmod +x /ndla-run-kong.sh

RUN apk update && apk add py2-pip jq && pip install awscli

## Taken from pull request on docker-kong: https://github.com/Mashape/docker-kong/pull/84/files
# ensure Kong logs go to the log pipe from our entrypoint and so to docker logging
RUN mkdir -p /usr/local/kong/logs \
    && ln -sf /tmp/logpipe /usr/local/kong/logs/access.log \
    && ln -sf /tmp/logpipe /usr/local/kong/logs/admin_access.log \
    && ln -sf /tmp/logpipe /usr/local/kong/logs/serf.log \
    && ln -sf /tmp/logpipe /usr/local/kong/logs/error.log

RUN ls -lR /etc/kong
CMD ./ndla-run-kong.sh

