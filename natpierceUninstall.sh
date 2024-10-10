#!/bin/bash

echo "Stopping and disabling Service"
sudo systemctl stop natpierce.service
sudo systemctl disable natpierce.service

echo "Removing natpierce.service"
sudo rm /etc/systemd/system/natpierce.service
sudo rm /etc/systemd/system/natpierce.service

sudo rm /usr/lib/systemd/system/natpierce.service
sudo rm /usr/lib/systemd/system/natpierce.service

echo "Removing /home/deck/.natpierce"
sudo rm /home/deck/.natpierce/config
sudo rm -r /home/deck/.natpierce/natpierce*


sudo systemctl daemon-reload
sudo systemctl reset-failed
echo "Done!"

#scripted by s6tiger
