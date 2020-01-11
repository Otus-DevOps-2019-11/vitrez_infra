#!/bin/bash
# add keys and repo of mongodb-org 3.2
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D68FA50FEA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'

# update apt and install mongodb-org
sudo apt update
sudo apt install -y mongodb-org

# start service mongod
sudo systemctl start mongod

# add to autostart
sudo systemctl enable mongod

# check status of mongod
sudo systemctl status mongod
