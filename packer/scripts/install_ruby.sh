#!/bin/bash
# update apt and install ruby
set -e
apt update
apt install -y ruby-full ruby-bundler build-essential

# check version
ruby -v
bundler -v
