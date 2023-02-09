#!/bin/bash

echo ''
echo "+++ Please check whether your RAILS_ENV: \"${RAILS_ENV}\""
echo ''

echo "* Start Frontend Services"
echo "** Start Webserver"
# nginx configuration is prepared for action-cable we do not use here..
bundle exec passenger start #--nginx-config-template nginx.conf.erb


echo "* Startup finished"

# Stay alive..
while true; do
    sleep 30
    echo "alive.. "
done