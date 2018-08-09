#!/bin/bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce htop
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

mkdir /mnt/html
sudo mount -t cifs //$3.file.core.windows.net/www /mnt/html -o vers=3.0,username=$3,password=$4,dir_mode=0777,file_mode=0777,sec=ntlmssp

sudo docker login arkadiumcom.azurecr.io -u $1 -p $2

mkdir -p /opt/arkadium/
cat <<EOF > /opt/arkadium/docker-compose.yml
version: "3"

services:

  frontend:
    image: arkadiumcom.azurecr.io/arkadiumcom/arkadiumcom/nginx-ssl-cahce:0.5
    ports:
      - "80:80"
      - "443:443"
    restart: always
    volumes:
      - data:/usr/share/nginx/wordpress
      - /mnt/html/wp-content/uploads/:/usr/share/nginx/wordpress/wp-content/uploads
      - /dev/shm/nginx-cache:/etc/nginx-cache
    depends_on:
      - datacontainer
  datacontainer:
    image: arkadiumcom.azurecr.io/arkadiumcom/arkadiumcom/datacontainer:0.2
    volumes:
      - data:/data
  omsagent:
    image: microsoft/oms
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/log:/var/log
      - /var/lib/docker/containers:/var/lib/docker/containers
    environment:
      - KEY=$6
      - WSID=$7
    ports:
      - "127.0.0.1:25225:25225"
      - "127.0.0.1:25224:25224/udp"
    privileged: true
    restart: always

volumes:
  data:

EOF

sudo echo "//$3.file.core.windows.net/www	/mnt/html	cifs	username=$3,password=$4,dir_mode=0777,file_mode=0777,sec=ntlmssp  0       0" >> /etc/fstab
sudo mount -a -t cifs
sudo echo "sudo docker-compose -f /opt/arkadium/docker-compose.yml up -d" >> /etc/rc.local
sudo docker-compose -f /opt/arkadium/docker-compose.yml up -d
