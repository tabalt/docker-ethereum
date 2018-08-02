#!/bin/sh

if [ -z "$HOSTNAME" ]; then 
    HOSTNAME="localhost";
fi

if [ -z "$ETHEREUM_HOME" ]; then 
    ETHEREUM_HOME="/usr/local/ethereum";
fi
if [ -z "$ETHEREUM_DATADIR" ]; then 
    ETHEREUM_DATADIR="${ETHEREUM_HOME}/data";
fi
if [ -z "$ETHEREUM_GENESIS_JSON" ]; then 
    ETHEREUM_GENESIS_JSON="${ETHEREUM_DATADIR}/genesis.json";
fi
if [ -z "$ETHEREUM_BOOTNODE_KEY" ]; then 
    ETHEREUM_BOOTNODE_KEY="${ETHEREUM_DATADIR}/bootnode.key";
fi

if [ -z "$ETHEREUM_NODE_DATADIR" ]; then 
    ETHEREUM_NODE_DATADIR="${ETHEREUM_DATADIR}/nodes/${HOSTNAME}";
fi
if [ -z "$ETHEREUM_NODE_INITFLAG" ]; then 
    ETHEREUM_NODE_INITFLAG="${ETHEREUM_NODE_DATADIR}/init.SUCCESS";
fi
if [ -z "$ETHEREUM_NODE_ROLE" ]; then 
    ETHEREUM_NODE_ROLE="mine";
fi