# Send "real" url to new version

cf map-route "<<parameters.appname>>-dark" "<<parameters.domain>>" \
      <<# parameters.live_subdomain>>-n "<<parameters.live_subdomain>>"<</ parameters.live_subdomain>>

# Stop sending traffic to previous version

cf unmap-route "<<parameters.appname>>" "<<parameters.domain>>" \
      <<# parameters.live_subdomain>>-n "<<parameters.live_subdomain>>"<</ parameters.live_subdomain>>

# stop previous version

cf stop "<<parameters.appname>>"

# delete previous version

cf delete "<<parameters.appname>>" -f

# Switch name of "dark" version to claim correct name

cf rename "<<parameters.appname>>-dark" "<<parameters.appname>>"