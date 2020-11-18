cf push --no-start "<<parameters.appname>>-dark" -f "<<parameters.manifest>>" \
      <<# parameters.vars>> --vars-file "<<parameters.vars>>"<</ parameters.vars>> \
      -p "<<parameters.package>>" \
      <<# parameters.dark_subdomain>> -n "<<parameters.dark_subdomain>>"<</ parameters.dark_subdomain>> \
      -d "<<parameters.domain>>"

cf set-env "<<parameters.appname>>-dark" CIRCLE_BUILD_NUM "${CIRCLE_BUILD_NUM}"
cf set-env "<<parameters.appname>>-dark" CIRCLE_SHA1 "${CIRCLE_SHA1}"
cf set-env "<<parameters.appname>>-dark" CIRCLE_WORKFLOW_ID "${CIRCLE_WORKFLOW_ID}"
cf set-env "<<parameters.appname>>-dark" CIRCLE_PROJECT_USERNAME "${CIRCLE_PROJECT_USERNAME}"
cf set-env "<<parameters.appname>>-dark" CIRCLE_PROJECT_REPONAME "${CIRCLE_PROJECT_REPONAME}"

# Push as "dark" instance (URL in manifest)

cf start "<<parameters.appname>>-dark"

# Ensure dark route is exclusive to dark app

cf unmap-route "<<parameters.appname>>" "<<parameters.domain>>" \
      <<# parameters.dark_subdomain>> -n "<<parameters.dark_subdomain>>"<</ parameters.dark_subdomain>> || echo "Already exclusive"
