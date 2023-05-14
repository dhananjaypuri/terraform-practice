#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo echo "This is created ny terraform" > /var/www/html/index.html
