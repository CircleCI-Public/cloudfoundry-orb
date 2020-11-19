Setup_Args() {
      if [ -n "$DD_VARS" ]; then
            ARGS_VARS="--vars-file $DD_VARS"
      fi
      if [ -n "$DD_SUBDOMAIN" ]; then
            ARGS_SUBDOMAIN="-n $DD_SUBDOMAIN"
      fi
}
Setup_Args

cf push --no-start "$DD_APPNAME-dark" -f "$DD_MANIFEST" \
      "$ARGS_VARS" \
      -p "$DD_PACKAGE" \
      "$ARGS_SUBDOMAIN" \
      -d "$DD_DOMAIN"

cf set-env "$DD_APPNAME-dark" CIRCLE_BUILD_NUM "${CIRCLE_BUILD_NUM}"
cf set-env "$DD_APPNAME-dark" CIRCLE_SHA1 "${CIRCLE_SHA1}"
cf set-env "$DD_APPNAME-dark" CIRCLE_WORKFLOW_ID "${CIRCLE_WORKFLOW_ID}"
cf set-env "$DD_APPNAME-dark" CIRCLE_PROJECT_USERNAME "${CIRCLE_PROJECT_USERNAME}"
cf set-env "$DD_APPNAME-dark" CIRCLE_PROJECT_REPONAME "${CIRCLE_PROJECT_REPONAME}"

# Push as "dark" instance (URL in manifest)

cf start "$DD_APPNAME-dark"

# Ensure dark route is exclusive to dark app

cf unmap-route "$DD_APPNAME" "$DD_DOMAIN" "$ARGS_SUBDOMAIN" || echo "Already exclusive"
