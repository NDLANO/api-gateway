#!/bin/sh
# Makes justifications in kong.yml to configure it to the rest of the environment

mv /etc/kong/kong.yml /etc/kong/kong.yml.bak

### BEWARE...
# This line removes all info in kong.yml before the 'nginx:'-element.
# This might not be what you want if the structure of the file changes. (It works fine for ver. 0.8.3)
###
sed '/^nginx:/,$!d' /etc/kong/kong.yml.bak > /etc/kong/kong.yml

echo -e '\n\n"proxy_listen": "0.0.0.0:80"' >> /etc/kong/kong.yml

# This is manipulating a yaml file. Beware of the blanks!!
echo -e '\n\ndatabase: "postgres"' >> /etc/kong/kong.yml
echo -e '\npostgres:'  >> /etc/kong/kong.yml
echo -e '  host: "'$DATABASE_HOST'"'  >> /etc/kong/kong.yml
echo -e '  port: 5432'  >> /etc/kong/kong.yml
echo -e '  database: "'$DATABASE_NAME'"'  >> /etc/kong/kong.yml
echo -e '  user: "'$DATABASE_USER'"'  >> /etc/kong/kong.yml
echo -e '  password: "'$DATABASE_USER_PASSWORD'"' >> /etc/kong/kong.yml
