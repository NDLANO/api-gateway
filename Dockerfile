FROM mashape/kong:0.8.3

COPY kong.yml.tmpl /etc/kong/kong.yml.tmpl
COPY start-kong.sh /start-kong.sh
RUN chmod +x /start-kong.sh

#CMD ["/start-kong.sh"]
CMD ./setup.sh && kong start
