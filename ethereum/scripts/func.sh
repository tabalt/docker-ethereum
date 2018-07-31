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

function init_ethereum_node()
{
    log_steps "init ethereum node";
    log_info "datadir: ${ETHEREUM_NODE_DATADIR}";

    while [[ ! -f "${ETHEREUM_NODE_INITFLAG}" ]]
    do
        geth --datadir ${ETHEREUM_NODE_DATADIR} init "${ETHEREUM_GENESIS}";
        if [ $? -eq 0 ];then
            log_info "init node success."
            mkdir -p ${ETHEREUM_NODE_DATADIR} && echo `date` > "${ETHEREUM_NODE_INITFLAG}";
        else
            log_info "init node failed, retry it after 5s."
            sleep 5
        fi
    done
}

function start_ethereum_node()
{
    log_steps "start ethereum node";
    log_info "datadir: ${ETHEREUM_NODE_DATADIR}";

    geth --datadir ${ETHEREUM_NODE_DATADIR} "$@"
}

function bootstrap()
{
    case $ETHEREUM_NODE_ROLE in
        "bootnode")
            init_ethereum_node;
            start_ethereum_node "$@"
            ;;
        "mine")
            init_ethereum_node
            start_ethereum_node --mine "$@"
            ;;
        "rpc")
            init_ethereum_node
            start_ethereum_node --rpc "$@"
            ;;
        *)
            log_info "unsupported ethereum node role: $ETHEREUM_NODE_ROLE"
            ;;
    esac
}
