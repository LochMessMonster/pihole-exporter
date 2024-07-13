#!/bin/sh

# Notes
# 
# - IP Regex isn't perfect and lets through >255,
#   but going for simple here
# - Needs to be updated for multiple hosts used

if [[ "$PIHOLE_HOSTNAME" =~ '^([0-9]{1,3}\.){3}[0-9]{1,3}$' ]]; then
    echo "PIHOLE_HOSTNAME is (probably) a valid IP"
    PIHOLE_IP=$PIHOLE_HOSTNAME
else
  echo "PIHOLE_HOSTNAME is not a valid IP. Manually resolving..."
  PIHOLE_IP=$(dig +short $PIHOLE_HOSTNAME)
  echo "$PIHOLE_HOSTNAME resolved to: $PIHOLE_IP"
fi

echo "Starting Pihole Exporter"
./pihole-exporter \
    -pihole_hostname $PIHOLE_IP \
    -pihole_port $PIHOLE_PORT \
    -pihole_api_token $PIHOLE_API_TOKEN \
    # -pihole_password $PIHOLE_PASSWORD \
    -port $PORT


    