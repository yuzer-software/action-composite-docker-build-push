#!/bin/sh
PACKAGE_LIST="fontconfig ttf-dejavu"
if type apk > /dev/null; then
    apk add --no-cache $PACKAGE_LIST
elif type apt-get > /dev/null; then
    apt-get update
    if [ $? = 100 ] ; then
        # Repo to use archive url due to issue using openjdk:17-slim-buster image because it is outdated
        # TODO migrate docker image
        echo "Failed to update packages with apt-get, use archive repo..."
        sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list
        sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list
        apt-get update
    fi
    apt-get install -y $PACKAGE_LIST \
        && rm -rf /var/lib/apt/lists/*
elif type yum > /dev/null; then
    yum -y install $PACKAGE_LIST \
        && yum -y clean all && rm -rf /var/cache
else
    echo "Error cannot found any package manager (apk,apt-get or yum)"
    exit 1;
fi
