#!/bin/bash

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

case "$1" in
    "local")
        echo "Provisioning local docker env"
        ansible-playbook -e "env=local" develop.yml
        ;;
    "development")
        echo  "Provisioning remote host"
        ansible-playbook -l unknown.fusionary.com -e "env=development" server.yml
        ;;
    "production")
        echo  "Provisioning remote host"
        ansible-playbook -l unknown.fusionary.com -e "env=production" server.yml
        ;;
    *) echo "Environment ${1} is not known. Use local, development, or production"
       ;;
esac
popd
