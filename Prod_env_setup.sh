#!/bin/bash

echo "Initializing Production environment settings"

echo "Installing Git"
sudo yum install git -y

echo "Installing Docker"
sudo yum install docker -y
sudo yum install docker-registry -y
sudo yum update device-mapper -y


echo "Installing vim"
sudo yum install vim -y


if [ ! -d "/usr/lib/jenkins" ]; then
	echo "Installing Jenkins"
	sudo mkdir jinstall
	cd jinstall
	sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
	sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
	sudo yum install jenkins -y
	sudo rm -r jinstall
	sudo service jenkins start
fi


