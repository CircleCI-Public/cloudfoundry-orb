BASE_INSTALLER_URL="https://packages.cloudfoundry.org/stable?release=${CLOUDFOUNDRY_BINARY_PLATFORM}64-binary&source=github&version=v${CLOUDFOUNDRY_BINARY_VERSION}"
echo "Downloading ${BASE_INSTALLER_URL}"
curl -L $BASE_INSTALLER_URL | tar -zx

if which sudo > /dev/null; then
	sudo mv cf /usr/local/bin
else
	mkdir -p $HOME/bin
	mv cf $HOME/bin
	echo "export PATH=\"${PATH}:${HOME}/bin\"" >> $BASH_ENV
fi

cf version
