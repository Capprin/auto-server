#!/bin/bash

# start server
cd /home/ec2-user/server/
screen -dmS minecraft java -Xms2048M -Xmx8192M -jar server.jar nogui

# update dns
echo "Getting IP from EC2 metadata"
IP=$( curl http://169.254.169.254/latest/meta-data/public-ipv4 )
HOSTED_ZONE_ID="Z2GSIKUMUM28Z5"
INPUT_JSON=$( cat /home/ec2-user/update-route53.json | sed "s/127\.0\.0\.1/$IP/" )
INPUT_JSON="{ \"ChangeBatch\": $INPUT_JSON }"
aws route53 change-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" --cli-input-json "$INPUT_JSON"