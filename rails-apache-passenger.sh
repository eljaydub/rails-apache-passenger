#!/bin/bash
#Check the readme and git log for latest info
#Run the following two commands before continuing
#sudo passwd ubuntu
#wget --no-check-certificate https://raw.github.com/joshfng/railsready/master/railsready.sh && bash railsready.sh
#Logout and then log back in and then run this script
#
#Tested on Ubuntu 12.04 on an AWS t1.micro instance 
#License: MIT
#Author: Lee Wasilenko

#Update and install necessary depedencies
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install apache2 libcurl4-openssl-dev apache2-threaded-dev libapr1-dev libaprutil1-dev libwww-perl nodejs

#Using ruby-1.9.3 to maintain compatibility with JRuby
#rvm install 1.9.3 # Leave out for now to reduce complexity
#rvm use --default 1.9.3 # Leave out for now to reduce complexity
gem install bundler
#--no-ri --no-rdoc flags for rails since this takes a very long time on an t1.micro instance
gem install --no-ri --no-rdoc rails 
gem install passenger
#Create some swap space so compiling goes smoother with limited RAM
sudo dd if=/dev/zero of=/swap bs=1M count=1024
sudo mkswap /swap
sudo swapon /swap
passenger-install-apache2-module

#Set apache config. If the user name you install rails and ruby with 
#is NOT ubuntu you'll have to modify the paths in the config
sudo cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
sudo cp apache2.conf /etc/apache2/apache2.conf
sudo chmod 644 /etc/apache2/apache2.conf

#Setup your VHost and enable the site
#Customize these to suit your app and server names
sudo cp my-ruby-app /etc/apache2/sites-available/my-ruby-app
sudo chmod 644 /etc/apache2/sites-available/my-ruby-app
sudo a2dissite default
sudo a2ensite my-ruby-app

#Build a default Rails app in /var/www/
#Customize this for your needs
sudo chmod o+w /var/www/
rails new /var/www/my-ruby-app
cd /var/www/my-ruby-app
bundle install
cd -
sudo chmod o-w /var/www/
sudo chown -R www-data:www-data /var/www/my-ruby-app

#Restart apache
sudo service apache2 restart

#You're good to go!
my_ec2_ip=`GET http://169.254.169.254/latest/meta-data/public-ipv4`
echo "Go to http://$my_ec2_ip/my-ruby-app to see your default rails web app"
echo "Thanks to Josh Frye, Wayne E. Seguin, Ryan McGeary, Hongli Lai & Ninh Bui"