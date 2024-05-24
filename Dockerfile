FROM kong:3.6.1-ubuntu
USER root

COPY ndla-run-kong.sh /ndla-run-kong.sh
COPY nginx.template /nginx.template
COPY nginx-caches-prod.conf nginx-caches-default.conf /
COPY nginx-api-cache.conf /nginx-api-cache.conf
RUN chmod +x /ndla-run-kong.sh

RUN apt-get update && apt-get install curl -y

ENV KONG_PROXY_ACCESS_LOG /dev/stdout
ENV KONG_ADMIN_ACCESS_LOG /dev/stdout
ENV KONG_PROXY_ERROR_LOG /dev/stderr
ENV KONG_ADMIN_ERROR_LOG /dev/stderr

CMD ./ndla-run-kong.sh

