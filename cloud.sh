#!/bin/sh

containerName="myapp"
hostIP=1234
ImageName="webapp"

ssh -t 127.0.0.1 "sudo command"

sudo docker -d &
sleep 5

echo "Killing previous docker container"

sudo docker kill $containerName
sudo docker rm $containerName

################OPTIONAL COMMAND################
if [ -f /var/run/docker.pid ]; then
sudo rm /var/run/docker.pid
fi
################OPTIONAL COMMAND################

if [ ! -d "jdk" ]; then
mkdir jdk
cd jdk
sudo wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-linux-x64.rpm
cd ..
fi


echo "Starting new docker container"
sudo docker build --no-cache -t=$ImageName .
sudo docker run -d --name $containerName -p=\"$hostIP:80\" $ImageName 
