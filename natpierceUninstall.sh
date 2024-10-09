#!/usr/bin/bash

echo "Stopping and disabling Service"
sudo systemctl stop natpierce.service
sudo systemctl disable natpierce.service

echo "Removing natpierce.service"
sudo rm -rf /etc/systemd/system/natpierce.service

echo "Removing /home/deck/.natpierce"
sudo rm -rf /home/deck/.natpierce

echo "Done!"
