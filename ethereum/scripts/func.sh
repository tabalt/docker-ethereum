#!/bin/sh

function log_steps()
{
    echo -e "\n--------------------------------------------------";
    echo -e "  $1";
    echo -e "--------------------------------------------------\n";
}
function log_info()
{
    echo -e "[`date`]\t$1"
}

function start_bootnode()
{
    log_steps "start bootnode";

    bootnode -nodekey "${ETHEREUM_BOOTNODE_KEY}" "$@"
}

function init_geth_node()
{
    log_steps "init geth node";
    log_info "datadir: ${ETHEREUM_NODE_DATADIR}";

    while [[ ! -f "${ETHEREUM_NODE_INITFLAG}" ]]
    do
        geth --datadir ${ETHEREUM_NODE_DATADIR} init "${ETHEREUM_GENESIS_JSON}";
        if [ $? -eq 0 ];then
            log_info "init node success."
            mkdir -p ${ETHEREUM_NODE_DATADIR} && echo `date` > "${ETHEREUM_NODE_INITFLAG}";
        else
            log_info "init node failed, retry it after 5s."
            sleep 5
        fi
    done
}

function start_geth_node()
{
    log_steps "start geth node";
    log_info "datadir: ${ETHEREUM_NODE_DATADIR}";

    geth --datadir ${ETHEREUM_NODE_DATADIR} "$@"
}

function bootstrap()
{
    case $ETHEREUM_NODE_ROLE in
        "bootnode")
            start_bootnode "$@"
            ;;
        "mine")
            init_geth_node
            start_geth_node --mine "$@"
            ;;
        "rpc")
            init_geth_node
            start_geth_node --rpc "$@"
            ;;
        *)
            log_info "unsupported ethereum node role: $ETHEREUM_NODE_ROLE"
            ;;
    esac
}
