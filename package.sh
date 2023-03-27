#!/bin/bash

# When mounting the git repo and running this script in the container
# the file permissions to not match what git expects. Adding the safe directory
# is required to enable the git information to be pulled succesfully.
git config --global --add safe.directory $(pwd)

MAJOR=1
MINOR=0
VERSION=$(git --no-pager log -n 1 --date=format:%Y%m%d --pretty=$MAJOR.$MINOR+%cd.%h)
NAME=minifi.deb

rm -rf deb

mkdir -p deb/DEBIAN

cp -v debian/* deb/DEBIAN/.
chmod 755 deb/DEBIAN/*

echo "Package: minifi
Version: $VERSION
Architecture: all
Maintainer: Stout
Description: Minificpp" > ./deb/DEBIAN/control

mkdir -p deb/opt/stout
mkdir -p deb/etc/ssl/certs
mkdir -p deb/etc/systemd/system

cp -v systemd/minifi.service deb/etc/systemd/system/.
# These files only exist in the docker container
tar xf /opt/nifi-minifi-cpp/build/nifi-minifi-cpp-0.10.0-bin.tar.gz -C deb/opt/stout/.
rm -rf deb/opt/stout/nifi-minifi-cpp-0.10.0/minifi-python
mv deb/opt/stout/nifi-minifi-cpp-0.10.0 deb/opt/stout/minifi

find ./deb -type d -exec chmod 755 {} \;

dpkg-deb --build deb $NAME

rm -rf deb

dpkg -I $NAME