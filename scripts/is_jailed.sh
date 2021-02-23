#!/bin/bash

SCRIPT_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P`
MONIKER='"YOUR_MONIKER"'

IS_JAILED=`docker exec orai_node oraid q staking validators -o json &> /tmp/val.json && cat /tmp/val.json | jq -r '.validators[] | select (.description.moniker=='${MONIKER}') | .jailed'`

if [[ ${IS_JAILED} == "true" ]]
then
    echo "`date` node is jailed"
     "${SCRIPT_DIR}/Send_msg_toTelBot.sh" "$HOSTNAME inform you:" "ALARM! Orai node is jailed"  2>&1 > /dev/null
    echo "`date` node is ok"
else
    echo "`date` node is ok"
fi

