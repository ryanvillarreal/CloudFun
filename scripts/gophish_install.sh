#!/bin/bash

sudo curl -s "https://api.github.com/repos/gophish/gophish/releases/latest" | jq -r '.assets[] | select(.name | endswith("linux-64bit.zip" )).browser_download_url' | sudo xargs curl -L -o /opt/gophish.zip --url
sudo unzip -qq /opt/gophish.zip -d /opt/gophish
sudo touch /opt/gophish/tmp.json
sudo jq '.admin_server.listen_url ="0.0.0.0:3333"' /opt/gophish/config.json | sudo tee /opt/gophish/tmp.json
sudo rm /opt/gophish/config.json && sudo mv /opt/gophish/tmp.json /opt/gophish/config.json
sudo mkdir /opt/gophish/log/
sudo touch /opt/gophish/log/gophish.log
sudo touch /opt/gophish/log/gophish.err
sudo cp /tmp/gophish.service /lib/systemd/system/gophish.service
sudo cp /tmp/gophish_service.sh /opt/gophish/gophish_service.sh
sudo chmod +x /opt/gophish/gophish_service.sh
sudo systemctl daemon-reload
sudo systemctl start gophish.service

