#!/bin/sh
# Makes justifications in kong.yml to configure it to the rest of the environment
mv /etc/kong/kong.yml /etc/kong/kong.yml.bak
sed '/^nginx:/,$!d' /etc/kong/kong.yml.bak > /etc/kong/kong.yml
echo -e '\ndatabase: "postgres"\npostgres:\n  host: "'$DATABASE_HOST'"\n  port: 5432\n  database: '$DATABASE_NAME'\n  user: "'$DATABASE_USER'"\n  password: "'$DATABASE_USER_PASSWORD'"\n' >> /etc/kong/kong.yml
