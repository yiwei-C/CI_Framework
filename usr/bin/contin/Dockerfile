FROM ubuntu:14.04

# Install prerequisites
run apt-get update
run apt-get install -y software-properties-common

# Install java8
run add-apt-repository -y ppa:webupd8team/java
run apt-get update
run echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
run apt-get install -y oracle-java8-installer
ADD http://mirrors.jenkins-ci.org/war/1.609/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins
# Install tools
run apt-get install -y git maven

# Clone project
run git clone https://github.com/Rootnotfound/cloud-conint.git

# Build project
run cd cloud-conint/swingapp && mvn verify dependency:copy-dependencies

# Expose the http port
expose 8080

workdir cloud-conint/swingapp
CMD java -DPROD_MODE=true -jar target/swingapp-0.0.1-SNAPSHOT.jar


