#!/bin/bash
ImageName="webapp"
hostIP=8080
containerName="myapp"


if [ $# != 1 ]; then
	echo "Usage: ./run.sh [OPTIONS]"
	echo ""
	echo "Options:"
	echo "	-r  		build and run the docker container"
	echo "	-s 			stop and remove the docker container"
	echo "	-h  		help"
	exit
elif [ $1 == "-r" ]; then	
		echo "build and start the docker container"
		sudo docker -d &
		sleep 5
		cd /
		#sudo docker build -t=$ImageName --no-cache vagrant
		sudo docker build -t=$ImageName vagrant
		sudo docker run -d --name $containerName -p=\"$hostIP:80\" $ImageName 
		cd /vagrant
elif [ $1 == "-s" ]; then
		echo "stop and romve the docker container"
		sudo docker -d &
		sleep 5
		sudo docker kill $containerName
		sudo docker rm $containerName

		if [ -f /var/run/docker.pid ]; then
		sudo rm /var/run/docker.pid
		fi
elif [ $1 == "-h" ]; then
	echo "Usage: ./run.sh [OPTIONS]"
	echo ""
	echo "Options:"
	echo "	-r  		build and run the docker container"
	echo "	-s  		stop and remove the docker container"
	echo "	-h  		help"
	exit
else 
	echo "Usage: ./run.sh [OPTIONS]"
	echo ""
	echo "Options:"
	echo "	-r  		build and run the docker container"
	echo "	-s  		stop and remove the docker container"
	echo "	-h  		help"
	exit
fi
