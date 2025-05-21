#!/bin/bash
set -e

VERSION="$1"
source ./build.properties
PROJECT="$NDLAOrganization/$NDLAComponentName"

if [ -z $VERSION ]
then
    VERSION="SNAPSHOT"
fi

docker build -o type=docker -t $PROJECT:$VERSION .
echo "BUILT $PROJECT:$VERSION"
