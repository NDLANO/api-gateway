-- READ/WRITE
CREATE USER api_gateway with PASSWORD '<passord>';

CREATE DATABASE api_gateway;
GRANT CONNECT ON DATABASE api_gateway to api_gateway;
