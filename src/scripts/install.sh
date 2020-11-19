: "${CF_USERNAME?Cloud Foundry username and password must be set as Environment variables before running this command.}"

: "${CF_PASSWORD?Cloud Foundry username and password must be set as Environment variables before running this command.}"

curl -v -L -o cf-cli_amd64.deb "https://cli.run.pivotal.io/stable?release=debian64&source=github"

sudo dpkg -i cf-cli_amd64.deb

cf -v
cf api "$INSTALL_ENDPOINT"
cf auth "$CF_USERNAME" "$CF_PASSWORD"
cf target -o "$INSTALL_ORG" -s "$INSTALL_SPACE"