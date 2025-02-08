# Mincraft Autostart / Autostop Server

Contains source and bash scripts for a cloud-hosted minecraft server that automatically stops during inactivity. A lambda-based webservice starts the cloud host when it receives an authenticated POST request.

## Cloud Resources

This project depends on:
- An AWS EC2 instance for running the actual server
- An AWS Lambda function, responsible for starting the EC2 instance when it receives the correct POST request
- (Optional) A static website, hosting a web form for submitting a startup request

## Setup

- Install top-level bash scripts and crontab on ec2 host, alongside a minecraft server install
    - Some of these appear optional or disabled by default (mc shutdown, backup)
    - Backup could probably be scheduled in crontab or on shutdown so you don't lose worlds.
- Install contents of lambda directory (edited for your specific setup) on a lambda function
- Host static site somewhere, edited for your specific lambda configuration.
