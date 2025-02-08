#!/bin/bash

FILENAME="world-$(date +'%Y-%m-%d').zip"

cd /home/ec2-user/server/

zip -r /tmp/$FILENAME world world_nether world_the_end

aws s3 cp /tmp/$FILENAME s3://capprin-minecraft/map/$FILENAME

rm /tmp/$FILENAME
