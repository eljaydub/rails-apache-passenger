#!/bin/bash
# Check the readme for latest info
#Run the following two commands before continuing
#sudo passwd ubuntu
#wget --no-check-certificate https://raw.github.com/joshfng/railsready/master/railsready.sh && bash railsready.sh
#Logout and then log back in and then run this script
#
#Tested on Ubuntu 12.04 on an AWS t1.micro instance 
#License: MIT
#Author: Lee Wasilenko

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install apache2 libcurl4-openssl-dev apache2-threaded-dev libapr1-dev libaprutil1-dev libwww-perl nodejs

rvm install 1.9.3
rvm use --default 1.9.3
gem install bundler rails passenger
sudo dd if=/dev/zero of=/swap bs=1M count=1024
sudo mkswap /swap
sudo swapon /swap
passenger-install-apache2-module

sudo cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
sudo cp apache2.conf /etc/apache2/apache2.conf
sudo chmod 644 /etc/apache2/apache2.conf

sudo cp my-ruby-app /etc/apache2/sites-available/my-ruby-app
sudo chmod 644 /etc/apache2/sites-available/my-ruby-app

sudo a2dissite default
sudo a2ensite my-ruby-app

sudo chmod o+w /var/www/
rails new /var/www/my-ruby-app
cd /var/www/my-ruby-app
bundle install
cd -
sudo chmod o-w /var/www/
sudo chown -R root:root /var/www/my-ruby-app

sudo service apache2 restart

my_ec2_ip=`GET http://169.254.169.254/latest/meta-data/public-ipv4`
echo "Go to http://$my_ec2_ip/my-ruby-app to see your default rails web app"
echo "Logout and log back in to start using rails"
echo "Thanks to Josh Frye, Wayne E. Seguin, Ryan McGeary, Hongli Lai & Ninh Bui"