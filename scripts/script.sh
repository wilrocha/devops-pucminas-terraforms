#!/bin/bash

# ----------- SETUP
sudo apt install nfs-common zip -y
sudo mkdir -p /htdocs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 10.0.1.254:/ /htdocs
sudo chmod 755 /htdocs
sudo wget https://www.free-css.com/assets/files/free-css-templates/download/page282/royal-cars.zip -O /htdocs/royal-cars.zip
sudo unzip /htdocs/royal-cars.zip -d /htdocs/
sudo mv /htdocs/car-rental-html-template/* /htdocs/

# ----------- DOCKER
sudo curl -sSL https://get.docker.com/ | sh
sudo docker run -d --name nginx -v /htdocs:/usr/share/nginx/html -p 80:80 nginx