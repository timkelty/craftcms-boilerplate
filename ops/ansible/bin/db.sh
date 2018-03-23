#!/bin/bash

ACTION=$1
STAGE=$2

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
VAULTPATH=`realpath $SCRIPTPATH/../`

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

pushd .
cd $VAULTPATH

if [ ! -f $VAULTFILE ]; then
    echo "Vault password file not found."
    popd
    exit 1
fi

if [ -z "$ACTION" ]; then
    echo "No action specified, use push or pull"
    popd
    exit 1
fi

if [ -z "$STAGE" ]; then
    echo "No stage specified, did you mean development or production?"
    popd
    exit 1
fi

case "$ACTION" in
    "pull")
        echo "Pulling database from ${STAGE}"
        ansible-playbook --extra-vars "env=${STAGE}" dbpull.yml
        ;;
    "push")
        echo "Pushing database to ${STAGE}"
        ansible-playbook --extra-vars "env=${STAGE}" dbpush.yml
        ;;
    *) echo "Unknown action: ${action}"
       exit 1
       ;;
esac
popd
