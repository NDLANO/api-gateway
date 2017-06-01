FROM kong:0.10.2

COPY ndla-run-kong.sh /ndla-run-kong.sh
RUN chmod +x /ndla-run-kong.sh

RUN yum --assumeyes install python-pip jq && \
 pip install awscli

## Taken from pull request on docker-kong: https://github.com/Mashape/docker-kong/pull/84/files
# ensure Kong logs go to the log pipe from our entrypoint and so to docker logging
RUN mkdir -p /usr/local/kong/logs \
    && ln -sf /tmp/logpipe /usr/local/kong/logs/access.log \
    && ln -sf /tmp/logpipe /usr/local/kong/logs/admin_access.log \
    && ln -sf /tmp/logpipe /usr/local/kong/logs/serf.log \
    && ln -sf /tmp/logpipe /usr/local/kong/logs/error.log

CMD ./ndla-run-kong.sh
