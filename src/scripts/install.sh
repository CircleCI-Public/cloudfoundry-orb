BASE_INSTALLER_URL="https://packages.cloudfoundry.org/stable?release=${CLOUDFOUNDRY_BINARY_PLATFORM}64-binary&source=github&version=v${CLOUDFOUNDRY_BINARY_PLATFORM}"
curl -L $BASE_INSTALLER_URL | tar -zx
mv cf /usr/local/bin

cf version
