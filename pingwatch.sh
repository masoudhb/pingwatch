#!/bin/bash

IP="8.8.8.8"
STATUS_FILE="/pingwatch/ping_status.txt"
PHP_SCRIPT="/pingwatch/send_alert.php"

while true; do
    ping -c 1 -W 1 $IP > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        CURRENT_STATUS="UP"
    else
        echo "$(date): First ping failed, waiting 30s to recheck..."
        sleep 30
        ping -c 1 -W 1 $IP > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            CURRENT_STATUS="UP"
        else
            CURRENT_STATUS="DOWN"
        fi
    fi

    if [ -f $STATUS_FILE ]; then
        LAST_STATUS=$(cat $STATUS_FILE)
    else
        LAST_STATUS=""
    fi

    if [ "$CURRENT_STATUS" != "$LAST_STATUS" ]; then
        echo "$CURRENT_STATUS" > $STATUS_FILE
        echo "$(date): Status changed to $CURRENT_STATUS"
        php $PHP_SCRIPT "$IP is $CURRENT_STATUS"
    fi

    sleep 30
done
