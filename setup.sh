#!/bin/bash

#Git_directory="https://github.com/qihongxu/ninja-sample.git"

echo "Running vagrant configuration script"

echo "Installing Git"
sudo yum install git -y
#cd /vagrant
#if [ ! -d "app" ]; then
#git clone $Git_directory
#fi
#cd /home/vagrant

echo "Installing Docker"
sudo yum install docker -y
sudo yum install docker-registry -y
sudo yum update device-mapper -y


echo "Installing vim"
sudo yum install vim -y

echo "Downloading Java package"
cd /vagrant
if [ ! -d "jdk" ]; then
mkdir jdk
cd jdk
sudo wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-linux-x64.rpm
fi

cd /vagrant
sudo chmod +rx run.sh

#echo "Installing Java"
#sudo yum install java-1.7.0 -y
#sudo yum install java-1.7.0-openjdk -y
#export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk-1.7.0.75-2.5.4.7.el7_1.x86_64

#echo "Installing unzip & zip"
#sudo yum install unzip -y
#sudo yum install zip -y

#if [ ! -d "/opt/maven" ]; then
#	echo "Installing Maven"
#	cd /tmp
#	wget http://supergsego.com/apache/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.zip 
#	unzip apache-maven-3.3.1-bin.zip 
#	sudo rm apache-maven-3.3.1-bin.zip
#	mv apache-maven-3.3.1/ /opt/maven
#	ln -s /opt/maven/bin/mvn /usr/bin/mvn
#	echo "#!/bin/bash
#	MAVEN_HOME=/opt/maven
#	PATH=\$MAVEN_HOME/bin:\$PATH
#	export PATH MAVEN_HOME
#	export CLASSPATH=.
#	export M2_HOME=/usr/local/maven
#	export PATH=\${M2_HOME}/bin:\${PATH}" > /etc/profile.d/maven.sh
#	chmod +x /etc/profile.d/maven.sh
#	source /etc/profile.d/maven.sh
#	cd ..
#fi

#if [ ! -d "/usr/lib/jenkins" ]; then
#	echo "Installing Jenkins"
#	sudo mkdir jinstall
#	cd jinstall
#	sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
#	sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
#	sudo yum install jenkins -y
#	sudo rm -r jinstall
#	sudo service jenkins start
#fi
