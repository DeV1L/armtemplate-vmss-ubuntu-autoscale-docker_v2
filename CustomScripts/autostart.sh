#!/bin/bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce htop

sudo docker login arkadiumcom.azurecr.io -u $1 -p $2
sudo docker run -d --name arkadiumcom -p 80:80 -p 443:443 arkadiumcom.azurecr.io/arkadiumcom/content-apache-ssl:latest

echo test > /tmp/test