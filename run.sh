#!/bin/bash

# Run integrations locally

# Import environment variables
if [ -f ./env.sh ]; then
  . ./env.sh
fi

# Build the project and the spring boot bundle
if [[ "$RUN_SH_SKIP_BUILD" != "true" ]]; then
  mvn clean install -Prun
fi

# Inject environment variables in application.yaml
rm -rf application.yaml
curl -s https://raw.githubusercontent.com/symphonyoss/contrib-toolbox/master/scripts/inject-vars.sh | bash -s -- ./local-run/application.yaml.template application.yaml

# Cleanup tomcat folder from previous runs
rm -rf tomcat ; mkdir tomcat

# Install and start ngrok
curl -O https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
chmod +x ngrok
./ngrok authtoken $NGROK_TOKEN
./ngrok http --subdomain hubspot.symphonyoss --log=stdout 8080 > ngrok.log &

# Run the Spring Boot application
java -Dlog4j2.outputAllToConsole=true -Dlogs.basedir=target \
-agentlib:jdwp=transport=dt_socket,server=y,address=5000,suspend=n \
-jar target/integration.jar \
--spring.profiles.active=$APP_ID \
--server.tomcat.basedir=$PWD/tomcat
