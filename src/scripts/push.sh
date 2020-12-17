Setup_Args() {
      if [ -n "$DEPLOY_VARS" ]; then
            ARGS_VARS="--vars-file $DD_VARS"
      fi
      if [ -n "$DEPLOY_PACKAGE" ]; then
            ARGS_PACKAGE="-n $DEPLOY_PACKAGE"
      fi
      if [ -n "$DEPLOY_PATH" ]; then
            ARGS_PATH="-p$DEPLOY_PATH"
      fi
}
Setup_Args

cf push --no-start "$DEPLOY_APPNAME" -f "$DEPLOY_MANIFEST" "$ARGS_VARS" "$ARGS_PACKAGE" "$ARGS_PATH"

cf set-env "$DEPLOY_APPNAME" CIRCLE_BUILD_NUM "${CIRCLE_BUILD_NUM}"
cf set-env "$DEPLOY_APPNAME" CIRCLE_SHA1 "${CIRCLE_SHA1}"
cf set-env "$DEPLOY_APPNAME" CIRCLE_WORKFLOW_ID "${CIRCLE_WORKFLOW_ID}"
cf set-env "$DEPLOY_APPNAME" CIRCLE_PROJECT_USERNAME "${CIRCLE_PROJECT_USERNAME}"
cf set-env "$DEPLOY_APPNAME" CIRCLE_PROJECT_REPONAME "${CIRCLE_PROJECT_REPONAME}"
#now start
cf start "$DEPLOY_APPNAME"
