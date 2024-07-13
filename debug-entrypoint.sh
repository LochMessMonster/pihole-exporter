#!/bin/sh

# Notes
# 
# - Add check to test PIHOLE_HOSTNAME is valid IP
#   which will skip dns resolution
# - Needs to be updated for multiple hosts used

# Manually resolve hostname
PIHOLE_IP=$(dig +short $PIHOLE_HOSTNAME)
echo "$PIHOLE_HOSTNAME resolved to: $PIHOLE_IP"

echo "Starting Pihole Exporter"
./pihole-exporter \
    -pihole_hostname $PIHOLE_IP \
    -pihole_port $PIHOLE_PORT \
    -pihole_api_token $PIHOLE_API_TOKEN \
    # -pihole_password $PIHOLE_PASSWORD \
    -port $PORT


    