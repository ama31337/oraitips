#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
INSYNC=`docker exec orai_node oraid status &> /tmp/status.json && cat /tmp/status.json | jq '.' | grep catching_up | grep "true"`

if [[ -z ${INSYNC} ]]
then
    echo "`date` node is synced"
else
    echo "`date` ALARM! node is out of sync"
     "${SCRIPT_DIR}/Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "ALARM! Orai node is out of sync"  2>&1 > /dev/null
fi

