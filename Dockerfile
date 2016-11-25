FROM kong:0.9.5

COPY ndla-run-kong.sh /ndla-run-kong.sh
RUN chmod +x /ndla-run-kong.sh

RUN yum --assumeyes install python-pip jq && \
 pip install awscli

CMD ./ndla-run-kong.sh
