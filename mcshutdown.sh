#!/bin/sh
SERVICE='server.jar'

# shut down instance if server stopped
if ! ps ax | grep -v grep | grep $SERVICE > /dev/null; then
	echo "Server not running; waiting 1 minute before retry"
	sleep 1m
	if ps ax | grep -v grep | grep $SERVICE > /dev/null; then
		exit 0
	fi
	echo "Server not running; shutting down in 1 minute"
	$(sudo /sbin/shudon -P +1)
fi
