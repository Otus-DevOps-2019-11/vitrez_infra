#!/bin/bash

cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

echo -e "[Unit]\nDescription=Puma HTTP Server\nAfter=network.target\n\n[Service]\nType=simple\nExecStart=/usr/local/bin/puma \nWorkingDirectory=/home/appuser/reddit \nRestart=on-failure\n\n[Install]\nWantedBy=multi-user.target\n" | sudo tee /etc/systemd/system/puma.service

systemctl daemon-reload

systemctl enable puma.service
systemctl start puma.service
systemctl status puma.service
