#!/bin/sh
PACKAGE_LIST="fontconfig ttf-dejavu"
if type apk > /dev/null; then
    apk add --no-cache $PACKAGE_LIST
elif type apt-get > /dev/null; then
    apt-get update && apt-get install -y $PACKAGE_LIST \
        && rm -rf /var/lib/apt/lists/*
elif type yum > /dev/null; then
    yum -y install $PACKAGE_LIST \
        && yum -y clean all && rm -rf /var/cache
else
    echo "Error cannot found any package manager (apk,apt-get or yum)"
    exit 1;
fi
