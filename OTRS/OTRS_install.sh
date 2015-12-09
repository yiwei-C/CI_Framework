#!/bin/bash

echo "Initial install of OTRS"

echo "Set the current SELinux status to ‘permissive’."
sudo setenforce Permissive

echo "Install MariaDB"
sudo yum install -y mariadb-server

echo "Create configuration file for OTRS"
sudo cp /vagrant/OTRS/otrs.cnf /etc/my.cnf.d

echo "Get and install OTRS"
sudo yum -y install http://ftp.otrs.org/pub/otrs/RPMS/rhel/7/otrs-5.0.4-01.noarch.rpm

echo "Install additional dependencies"
sudo yum -y install epel-release
sudo yum install -y mod_perl "perl(Crypt::Eksblowfish::Bcrypt)" "perl(JSON::XS)" "perl(GD::Text)" "perl(Encode::HanExtra)" "perl(GD::Graph)" "perl(Mail::IMAPClient)" "perl(PDF::API2)" "perl(Text::CSV_XS)" "perl(YAML::XS)"

echo "Configure firewall and start Apache"
sudo rm /etc/httpd/conf.d/welcome.conf
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --reload