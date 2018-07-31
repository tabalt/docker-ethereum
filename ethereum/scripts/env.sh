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
if [ -z "$ETHEREUM_GENESIS" ]; then 
    ETHEREUM_GENESIS="${ETHEREUM_DATADIR}/genesis.json";
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