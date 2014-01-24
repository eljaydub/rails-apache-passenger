#rails-apache-passenger
======================

A simple setup script that will install and setup all of the dependencies needed to deploy a simple Rails app with Apache and Passenger on an Ubuntu 12.04 EC2 instance.

##Use

First set a password for the ubuntu user with 

`sudo psswd ubuntu`

Then run the railsready script from joshfng with 

`wget --no-check-certificate https://raw.github.com/joshfng/railsready/master/railsready.sh && bash railsready.sh`

Log out and back in again as suggested by the script.

Now clone and run the rails-apache-passenger script

`git clone https://github.com/eljaydub/rails-apache-passenger.git`
`./rails-apache-passenger/rails-apache-passenger.sh`
