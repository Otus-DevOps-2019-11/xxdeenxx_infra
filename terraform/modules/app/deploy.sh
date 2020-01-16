#!/bin/bash
set -e

APP_DIR=${1:-$HOME}

git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install

sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo chown -R appuser:appuser /home/appuser/reddit
sudo cp /var/lib/gems/2.3.0/gems/puma-3.10.0/lib/puma.rb /home/appuser/reddit/puma.rb
sudo systemctl daemon-reload
sudo systemctl start puma
sudo systemctl enable puma
