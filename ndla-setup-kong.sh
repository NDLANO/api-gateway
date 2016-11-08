#!/bin/sh
# Makes justifications in kong.yml to configure it to the rest of the environment

mv /etc/kong/kong.yml /etc/kong/kong.yml.bak

### BEWARE...
# This line removes all info in kong.yml before the 'nginx:'-element.
# This might not be what you want if the structure of the file changes. (It works fine for ver. 0.8.3)
###
sed '/^nginx:/,$!d' /etc/kong/kong.yml.bak > /etc/kong/kong.yml

secretsfile="/tmp/secrets"
aws s3 --region eu-central-1 cp s3://$NDLA_ENVIRONMENT.secrets.ndla/api_gateway.secrets $secretsfile

# This is manipulating a yaml file. Beware of the blanks!!
echo -e '\n\ndatabase: "postgres"' >> /etc/kong/kong.yml
echo -e '\npostgres:'  >> /etc/kong/kong.yml
echo -e "  host: \"$(cat $secretsfile | jq -r .META_SERVER)\""  >> /etc/kong/kong.yml
echo -e "  port: $(cat $secretsfile | jq -r .META_PORT)"  >> /etc/kong/kong.yml
echo -e "  database: \"$(cat $secretsfile | jq -r .META_RESOURCE)\""  >> /etc/kong/kong.yml
echo -e "  user: \"$(cat $secretsfile | jq -r .META_USER_NAME)\""  >> /etc/kong/kong.yml
echo -e "  password: \"$(cat $secretsfile | jq -r .META_PASSWORD)\"" >> /etc/kong/kong.yml

rm $secretsfile