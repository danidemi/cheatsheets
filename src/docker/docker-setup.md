## Install on Ubuntu 14.04 ##

This is to set the docker repo in ubuntu

	$ wget https://get.docker.com/ubuntu/ --output-document=./check-docker.sh
	$ chmod u+x check-docker.sh
	$ sudo ./check-docker.sh

This is to update Ubuntu

	$ sudo apt-get update
	$ sudo apt-get -y install lxc-docker

This is to try Docker

	$ sudo docker run -i -t ubuntu /bin/bash

If it works well it should output something like that.

	$ sudo docker run -i -t ubuntu /bin/bash
	Unable to find image 'ubuntu:latest' locally
	ubuntu:latest: The image you are pulling has been verified
	511136ea3c5a: Pull complete 
	3b363fd9d7da: Pull complete 
	607c5d1cca71: Pull complete 
	f62feddc05dc: Pull complete 
	8eaa4ff06b53: Pull complete 
	Status: Downloaded newer image for ubuntu:latest
	root@953fa5507b96:/#

Try a couple of commands and exit.

	root@953fa5507b96:/# whoami
	root
	root@953fa5507b96:/# hostname
	953fa5507b96
	root@953fa5507b96:/# exit

To avoid using "sudo" there's a special user group available.

	# Add the docker group if it doesn't already exist.
	$ sudo groupadd docker

	# Add the connected user "${USER}" to the docker group.
	# You may have to logout and log back in again.
	$ sudo gpasswd -a ${USER} docker

	# Restart the Docker daemon.
	# If you are in Ubuntu 14.04, use docker.io instead of docker
	$ sudo service docker restart
	$ sudo service docker.io restart
