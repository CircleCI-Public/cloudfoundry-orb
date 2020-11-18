cf push --no-start "<<parameters.appname>>" -f "<<parameters.manifest>>" \
      <<#parameters.vars>> --vars-file "<<parameters.vars>>" <</ parameters.vars>> \
      <<#parameters.package>> -p "<<parameters.package>>" <</ parameters.package>>

cf set-env "<<parameters.appname>>" CIRCLE_BUILD_NUM "${CIRCLE_BUILD_NUM}"
cf set-env "<<parameters.appname>>" CIRCLE_SHA1 "${CIRCLE_SHA1}"
cf set-env "<<parameters.appname>>" CIRCLE_WORKFLOW_ID "${CIRCLE_WORKFLOW_ID}"
cf set-env "<<parameters.appname>>" CIRCLE_PROJECT_USERNAME "${CIRCLE_PROJECT_USERNAME}"
cf set-env "<<parameters.appname>>" CIRCLE_PROJECT_REPONAME "${CIRCLE_PROJECT_REPONAME}"
#now start
cf start "<<parameters.appname>>"