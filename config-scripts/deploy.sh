#!/bin/bash

# let's go home
cd ~

# download sources
git clone -b monolith https://github.com/express42/reddit.git

# install dependencies
cd reddit && bundle install

# start server
puma -d

# check status and port
ps aux | grep puma
