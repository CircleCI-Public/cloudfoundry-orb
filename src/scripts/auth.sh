: "${CF_USERNAME?Cloud Foundry username and password must be set as Environment variables before running this command.}"

: "${CF_PASSWORD?Cloud Foundry username and password must be set as Environment variables before running this command.}"

cf api "$INSTALL_ENDPOINT"
cf auth "$CF_USERNAME" "$CF_PASSWORD"
cf target -o "$INSTALL_ORG" -s "$INSTALL_SPACE"

