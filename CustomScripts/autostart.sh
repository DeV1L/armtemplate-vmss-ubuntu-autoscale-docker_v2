#!/bin/bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce htop

sudo mount -t cifs //$3.file.core.windows.net/www /mnt/ -o vers=3.0,username=$3,password=$4,dir_mode=0777,file_mode=0777,sec=ntlmssp

sudo docker login arkadiumcom.azurecr.io -u $1 -p $2
sudo docker run -d --name arkadiumcom -p 80:80 -p 443:443 -v /mnt:/var/www arkadiumcom.azurecr.io/arkadiumcom/content-apache-ssl:latest
