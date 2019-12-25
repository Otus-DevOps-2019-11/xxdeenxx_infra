#!/bin/bash
set -e

cd
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
sudo cp /tmp/puma.service /etc/systemd/system/
sudo chown -R appuser:appuser /home/appuser/reddit
sudo cp /var/lib/gems/2.3.0/gems/puma-3.10.0/lib/puma.rb /home/appuser/reddit/puma.rb
sudo systemctl daemon-reload
sudo systemctl enable puma.service
