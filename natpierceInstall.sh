#!/bin/bash
#set -e

echo "Enter Version ID:"
read Version_ID


# sudo systemctl stop natpierce.service
# echo "Stopping current natpierce service"

echo "Downloading natpierce one binary..."
sudo killall natpierce

mkdir -p /home/deck/.natpierce && cd /home/deck/.natpierce
wget  "https://natpierce.oss-cn-beijing.aliyuncs.com/linux/natpierce-amd64-v$Version_ID.tar.gz" -O natpierce$Version_ID.tar.gz

tar -xzvf natpierce$Version_ID.tar.gz


echo "Configuring natpierce..."
chmod +x natpierce


sudo steamos-readonly disable

# # Add service file to run at startup
# mkdir -p $HOME/.config/systemd/user

# Paste whole command
sudo cat <<EOF > /etc/systemd/system/natpierce.service
[Unit]
Description=natpierce
After=network.target

[Service]
ExecStart=/bin/bash -c "sudo /home/deck/.natpierce/natpierce"
ExecStop=/bin/bash -c "sudo killall natpierce"
WorkingDirectory=/home/deck/.natpierce/
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
# -----

sudo steamos-readonly enable

# echo "Running natpierce..."
# sudo ./natpierce

# Binary will be run as a user service, but needs root, so add permission to run sudo without password for natpierce
#echo "%wheel ALL=(ALL) NOPASSWD: $HOME/.natpierce/natpierce" | pkexec tee /etc/sudoers.d/natpierce

#
# # Add service file to run at startup
# mkdir -p $HOME/.config/systemd/user
#
# # Paste whole command
# cat <<EOF > $HOME/.config/systemd/user/natpierce.service
# [Unit]
# After=network.target
#
# [Service]
# ExecStart=/usr/bin/sudo %h/.natpierce/natpierce
# Restart=on-failure
#
# [Install]
# WantedBy=default.target
# EOF
# # -----
#
echo "Starting natpierce service..."
# systemctl --user daemon-reload
# systemctl --user enable --now natpierce.service

sudo systemctl daemon-reload
sudo systemctl enable --now natpierce.service
echo "Showing natpierce service status..."
sudo systemctl status natpierce.service

#Scipted by s6tiger
