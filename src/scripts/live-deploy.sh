Setup_Args() {
      if [ -n "$LD_SUBDOMAIN" ]; then
            ARGS_SUBDOMAIN="-n $LD_SUBDOMAIN"
      fi
}
Setup_Args

# Send "real" url to new version
cf map-route "$LD_APPNAME-dark" "$LD_DOMAIN" "$ARGS_SUBDOMAIN"

# Stop sending traffic to previous version
cf unmap-route "$LD_APPNAME" "$LD_DOMAIN" "$ARGS_SUBDOMAIN"

# stop previous version
cf stop "$LD_APPNAME"
# delete previous version
cf delete "$LD_APPNAME" -f
# Switch name of "dark" version to claim correct name
cf rename "$LD_APPNAME-dark" "$LD_APPNAME"