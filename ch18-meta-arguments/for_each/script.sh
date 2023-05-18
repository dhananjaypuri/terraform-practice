#!/bin/bash
apt update -y
apt install apache2 -y
echo "This is deployed from Terraform" > /var/www/html/index.html
