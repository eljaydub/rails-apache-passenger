rails-apache-passenger
======================

A simple setup script that will install and setup all of the dependencies needed to deploy a simple Rails app with Apache and Passenger on an Ubuntu 12.04 EC2 instance.

Use
==========

First set a password for the ubuntu user with 

sudo psswd ubuntu

Then run the railsready script from joshfng with 

wget --no-check-certificate https://raw.github.com/joshfng/railsready/master/railsready.sh && bash railsready.sh
