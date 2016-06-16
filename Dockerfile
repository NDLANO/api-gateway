FROM mashape/kong:0.8.3

COPY ndla-setup-kong.sh /ndla-setup-kong.sh
RUN chmod +x /ndla-setup-kong.sh

CMD ./ndla-setup-kong.sh && kong start
