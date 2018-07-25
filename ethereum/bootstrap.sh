#!/bin/sh

function steps_notice()
{
    echo -e "\n--------------------------------------------------";
    echo -e "  $1";
    echo -e "--------------------------------------------------\n";
}

function log_info()
{
    echo -e "[`date`]\t$1"
}

if [ -z "$ETHEREUM_HOME" ]; then 
    ETHEREUM_HOME="/usr/local/ethereum";
fi
if [ -z "$ETHEREUM_DATADIR" ]; then 
    ETHEREUM_DATADIR="${ETHEREUM_HOME}/data";
fi
if [ -z "$HOSTNAME" ]; then 
    HOSTNAME="localhost";
fi

ETHEREUM_NODE_DATADIR="${ETHEREUM_DATADIR}/nodes/${HOSTNAME}";
ETHEREUM_NODE_INITFLAG="${ETHEREUM_NODE_DATADIR}/init.SUCCESS";

steps_notice "init ethereum node";
log_info "datadir: ${ETHEREUM_NODE_DATADIR}";

while [[ ! -f "${ETHEREUM_NODE_INITFLAG}" ]]
do
    geth --datadir ${ETHEREUM_NODE_DATADIR} init "${ETHEREUM_DATADIR}/genesis.json";
    if [ $? -eq 0 ];then
        log_info "init node success."
        mkdir -p ${ETHEREUM_NODE_DATADIR} && echo `date` > "${ETHEREUM_NODE_INITFLAG}";
    else
        log_info "init node failed, retry it after 5s."
    fi
    sleep 5
done

steps_notice "start ethereum node";
log_info "datadir: ${ETHEREUM_NODE_DATADIR}";

geth --datadir ${ETHEREUM_NODE_DATADIR} "$@"
