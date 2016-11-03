#!/bin/sh

# This script pulls the api spec from the local server and generates the Angular2 bindings to app/api
# Make sure the server is running on localhost:8080

# Also, swagger-codegen 2.2.0 does not generate correct bindings (no content-type headers are generated) which is why the version here is built from the (not yet released) 2.3.0 sources
# See: https://github.com/swagger-api/swagger-codegen

java -jar swagger-codegen-cli.jar generate -i "http://localhost:8080/v2/api-docs" -l "typescript-angular2" -o ./api_new
rm -r app/api
mv ./api_new app/api
