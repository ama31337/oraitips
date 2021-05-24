#!/bin/bash

# set variables
APP_NAME='oraid'
SERVICE_NAME='orai'

APP_PATH="${HOME}/.local/bin/${APP_NAME}"
EXTRA_ARG="start --p2p.pex false --p2p.persistent_peers "49ea61a93c146320d076da0edbcc11107a81d4c5@18.224.44.191:26656" --home $HOME/.oraid"

# create systemd file
cat > $HOME/${SERVICE_NAME}.service <<EOF
[Unit]
Description=oraid service
After=network.target

[Service]
Type=simple
Restart=always
RestartSec=1
LimitNOFILE=1024000
User=$USER
ExecStart=$APP_PATH $EXTRA_ARG

[Install]
WantedBy=default.target
EOF

sudo mv $HOME/${SERVICE_NAME}.service /etc/systemd/system/${SERVICE_NAME}.service
sudo systemctl daemon-reload

# create aliases
echo "" >> ~/.bashrc
echo "# ${SERVICE_NAME} alias" >> ~/.bashrc
echo "alias ${SERVICE_NAME}start='sudo systemctl start ${SERVICE_NAME}.service'" >> ~/.bashrc
echo "alias ${SERVICE_NAME}stop='sudo systemctl stop ${SERVICE_NAME}.service'" >> ~/.bashrc
echo "alias ${SERVICE_NAME}restart='sudo systemctl restart ${SERVICE_NAME}.service'" >> ~/.bashrc
echo "alias ${SERVICE_NAME}logs='sudo journalctl -u ${SERVICE_NAME} -f'" >> ~/.bashrc
source ~/.bashrc


echo "done, now run"
echo "source ~/.bashrc"
echo "And you can start new service with '${SERVICE_NAME}start' command"

