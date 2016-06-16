#!/bin/sh
# Create kong.yml by reading nginx.tmpl and replace envoriment variables for the placeholders ${ENVIROMENT_VARIABLE_NAME} and save the result to kong.yml.
awk '{while(match($0,"[$]{[^}]*}")) {var=substr($0,RSTART+2,RLENGTH -3);gsub("[$]{"var"}",ENVIRON[var])}}1' < /kong.yml.tmpl > /kong.yml

# Start nginx in the foreground.
kong start -c /kong.yml
