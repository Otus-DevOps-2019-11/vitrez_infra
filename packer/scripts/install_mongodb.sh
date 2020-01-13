#!/bin/bash
set -e
# add keys and repo of mongodb-org 3.2
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D68FA50FEA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list

# update apt and install mongodb-org
apt update
apt install -y mongodb-org

# start service mongod
sudo systemctl start mongod

# add to autostart
sudo systemctl enable mongod

# check status of mongod
sudo systemctl status mongod
