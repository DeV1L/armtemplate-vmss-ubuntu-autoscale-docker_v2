#!/bin/bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce htop

mkdir /mnt/html
sudo mount -t cifs //$3.file.core.windows.net/www /mnt/html -o vers=3.0,username=$3,password=$4,dir_mode=0777,file_mode=0777,sec=ntlmssp

sudo docker login arkadiumcom.azurecr.io -u $1 -p $2
sudo docker run -d --name arkadiumcom -p 80:80 -p 443:443 -v /mnt/html:/usr/share/nginx/wordpress arkadiumcom.azurecr.io/arkadiumcom/arkadiumcom/nginx-ssl-cahce
