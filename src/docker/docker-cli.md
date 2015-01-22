## Docker CLI ##

* main commands
	* run
		* run processes in isolated container
		* can override CMD defined in the image
		* detached vs foreground
			* detached
				* container is no longer listening to the command line where you executed docker run
				* all I/O done through 
					* network connections 
					* shared volumes 			
			* foreground
				* start the process in the container 
				* attach the console
				
	* exec
		* run a new command in a running container
		
	* start
		* start a stopped container
	* stop
		* stop a running container
	* attach 
		* attach a tty to a running container
				
					
		

### docker run ###

Runs a command in a container keeping the container alive until the command exit

	sudo docker run [flags] <image[:version]> <hostcommand>
	-t          : assign a pseudo terminal
	-i          : interactive connection	
	-P          : tells Docker to map any required network ports inside our container to a random port on the host.
	-p          : allows to map a container port to an host port, <host_ip>:<host_port>:<container_port> i.e. -p 5000:5000
        -e, --env=[]: Set environment variables. I.e. -e POSTGRES_PASSWORD=postgres


#### Examples ####

Invoke /bin/echo and exit immediately

	$ sudo docker run ubuntu:14.04 /bin/echo 'Hello world'

Launch bash on a new container instance

	$ sudo docker run -t -i ubuntu /bin/bash

Run a simple script in a deamonized docker

	$sudo docker run -d ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"

### docker ps ###

Prints info on docker containers, like ps for processes.

	sudo docker ps [flags]

	-a	:	Shows stopped containers too
	-l	:	Shows last started container

#### Examples ####

Prints out the docker containers

	sudo docker ps

### docker logs ###

The docker logs command looks inside the container and returns its standard output

	sudo docker logs <instance_name>

	-f	:	Keep on tailing, like tail -f

#### Examples ####

Prints out the stdout of the insane_babbage instance. You would run docker ps to discover the instance name.

	$ sudo docker logs insane_babbage

### docker version ###

Prints out info about the docker environment.

	sudo docker version

#### Example ####

	$ sudo docker version
	Client version: 1.4.1
	Client API version: 1.16
	Go version (client): go1.3.3
	Git commit (client): 5bc2ff8
	OS/Arch (client): linux/amd64
	Server version: 1.4.1
	Server API version: 1.16
	Go version (server): go1.3.3
	Git commit (server): 5bc2ff8

### docker port ###

Immediately show the port of the host that correspond to the port in docker

	$ sudo docker port <instance> [port_in_docker]

#### Examples ####

Prints all the ports mapping for the "compassionate_heisenberg" instance.
This means that to reach the service running on 5000/tcp on the container, you should connect on localhost:49153

	$ sudo docker port compassionate_heisenberg
	5000/tcp -> 0.0.0.0:49153

### docker rm ###

Remove a container. Should be already stopped.

	docker rm <host>

### docker images ###

List images downloaded to the host

	docker images

### Help ###

Prints all docker commands.

	docker

Prints help for the given command, if such command accept some params.

	docker <command>

Prints help for the given command

	docker <command> --help


