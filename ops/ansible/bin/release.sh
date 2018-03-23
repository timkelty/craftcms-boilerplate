
#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
VAULTPATH=`realpath $SCRIPTPATH/../`
TIMESTAMP=`date +%Y%m%d%H%M%S`

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

pushd .
cd $VAULTPATH

case "$1" in
    "development")
        echo  "Tagging development release"
        TAGNAME="development-${TIMESTAMP}"
        git tag $TAGNAME
        git push $origin TAGNAME
        ;;
    "production")
        echo  "Tagging production release"
        TAGNAME="production-${TIMESTAMP}"
        git tag $TAGNAME
        git push origin $TAGNAME
        ;;
    *) echo "Environment ${1} is not known. Use development or production"
       ;;
esac
popd
