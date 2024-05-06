FROM kong:2.8.3-alpine
USER root

COPY ndla-run-kong.sh /ndla-run-kong.sh
COPY nginx.template /nginx.template
COPY nginx-caches-prod.conf nginx-caches-default.conf /
COPY nginx-api-cache.conf /nginx-api-cache.conf
RUN chmod +x /ndla-run-kong.sh

RUN apk update && \
    apk add --no-cache curl
RUN apk upgrade
ENV KONG_PROXY_ACCESS_LOG /dev/stdout
ENV KONG_ADMIN_ACCESS_LOG /dev/stdout
ENV KONG_PROXY_ERROR_LOG /dev/stderr
ENV KONG_ADMIN_ERROR_LOG /dev/stderr

CMD ./ndla-run-kong.sh

