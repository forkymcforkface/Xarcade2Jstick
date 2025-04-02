#!/bin/bash

# Run the make install and make installservice commands with sudo
sudo make install
sudo make installservice

# Overwrite the systemd service file with the custom definition
sudo tee /lib/systemd/system/xarcade2jstick.service > /dev/null <<EOF
[Unit]
Description=Xarcade2Jstick

[Service]
Type=oneshot
ExecStart=/usr/local/bin/xarcade2jstick -s
TimeoutStartSec=300ms

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to recognize the new service definition
sudo systemctl daemon-reexec
sudo systemctl daemon-reload

# Enable and start the modified service
sudo systemctl enable xarcade2jstick

# Sync and reboot
sync
sudo reboot
