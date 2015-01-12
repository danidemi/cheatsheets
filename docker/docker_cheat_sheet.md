Docker 
======

## Big Picture ##

 * Docker is 
	* an open source platform 
	* for 
		* developers 
		* and sysadmins 
	* to 
		* build
		* ship 
		* run
			* distributed applications

* Docker Platform is made up by
	* Docker Engine
		* a portable 
		* lightweight 
		* runtime
	* a packaging tool
	* and Docker Hub 
		* a cloud service for 
			* sharing Images of dockerized applications
			* automating workflows

* With Docker you can do things like
	* run applications that have been previously dockerized
		* in comlpete isolation
			* more or less as it would be run in a virtual machine
	* setuplessly link Docker containers
		* i.e.
			* run container#1 with a web appication
			* run container#2 with the db needed by the web app
		* applications should be built to work together.
	* extend available images in order to create new immutable images 
		* share it across you team
			* in order to have a standard environment
	* create a repeatable environment
		* put image definitions and container creation in a script in your codebase
			* all members will have same env
	* develop / deploy / run the **very same** environment
		* extend a useful image
		* including your dockerized app in it
		* share the image
		* create a container in prod from the same image

* Run on
	* Modern Linux
		* Docker needs
			* libvirt, 
			* LXC (Linux containers) 
			* and systemd-nspawn
	* Win (and maybe older Linux) through a VM
		* https://github.com/boot2docker/boot2docker
		* Azure supports Docker
		* forthcoming support in Windows Server





### Docker Engine ###

* Docker Engine
	* uses
		* resource isolation features of Linux kernel
			* to
				* allow independent "containers" to run within a single Linux instance
		* union mount to provide the Union File System





### Trusted / Automated Builds ###

Automated Builds are a special feature of Docker Hub which allow you to use Docker Hub's build clusters to automatically create images from a specified Dockerfile and a GitHub or Bitbucket repo.

### Docker Hub ###

* Official Docker Hub
	* to
		* store Images in repositories
		* search and browse Images
	* is a 
		* Paas
		* Docker-owned
	* costs
		* public repositories 
			* free for all
		* private repositories
			* fees apply

* Run-by-yourself Docker Hub
	* Docker Hub software is open source
		* https://github.com/docker/docker-registry - current
		* https://github.com/docker/distribution - forthcoming

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

If we go on like that, all docker commands should be issued through 'sudo'.

	# Add the docker group if it doesn't already exist.
	$ sudo groupadd docker

	# Add the connected user "${USER}" to the docker group.
	# You may have to logout and log back in again.
	$ sudo gpasswd -a ${USER} docker

	# Restart the Docker daemon.
	# If you are in Ubuntu 14.04, use docker.io instead of docker
	$ sudo service docker restart
	$ sudo service docker.io restart






## Best practices & pattern ##

### Be repeatable ###

Main goal is to be able to create the very same container whenever you need it.

### Be portable ###

Main goal is to be able to run the very same container on different platforms.

### Don't boot init ###

* Containers model processes not machines
* The goal is that you only run one process per container 
* So an init or supervisor is not needed. 
* If the processes dies inside a container then the container dies
* Instead of restarting the process just restart the same container or a new container

### Don't upgrade in builds ###

* Updates will be baked into the based images you don't need to apt-get upgrade your containers.
* If there are security updates that a base image needs, 
let upstream know so that they can update it for everyone and ensure that your builds are consistent again.
* so 
	* best case you run an upgrade in a build and it works. 
	* worse case a pkg tries to mount, etc and it fails. 
* you should bake security fixes into the base images and rebuild on top of them so that the end result is consistent. 
* The end goal is that the image i build today is the same image that will be built tomorrow unless i explicitly say other wise.

### Use small base images ###

Some images are more bloated than others. I suggest using debian:jessie as your base.

### Use specific tags ###

#### Use specific tags when specifying FROM images ####

This is important for your base images. 
Your FROM should always contain the full repository and tag for the base image that you are depending on. 
FROM debian:jessie not just FROM debian

#### Use specific tags for your images ####

Unless you are experimenting with docker you should always pass the -t option to docker build so that the resulting image is tagged. 
A simple human readable tag will help you manage what each image was created for.

	docker build -t="crosbymichael/sentry" .

Always pass -t to tag the resulting image.

### Use the cache ###

Keep common instructions at the top of the Dockerfile to utilize the cache.

Each instruction in a Dockerfile commits the change into a new image which will then be used as the base of the next instruction. 
If an image exists with the same parent and instruction ( except for ADD ) docker will use the image instead of executing the instruction, i.e. the cache.

### EXPOSE-ing ports ### 

Images should able to run on any host and as many times as needed. 
With Dockerfiles you have the ability to map the private and public ports, 
however, you should never map the public port in a Dockerfile. 
By mapping to the public port on your host you will only be able to have one instance of your dockerized app running.

	# private and public mapping
	EXPOSE 80:8080

	# private only
	EXPOSE 80

If the consumer of the image cares what public port the container maps to they will pass the -p option when running 
the image, otherwise, docker will automatically assign a port for the container.

Never map the public port in a Dockerfile.

### CMD and ENTRYPOINT syntax ###

Always use the array syntax.

### Log to stdout ###

The docker logs command looks inside the container and returns its standard output.
So, log to stdout to make logs available to the client.






## Commands ##

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






## Networking ##

By default, every time a container is restarted, it binds to different host ports.






## Images ##

* Docker images are the basis of containers
* If an image isn't already present on the host then it'll be downloaded from a registry
	* by default the Docker Hub Registry
* Docker stores downloaded images on the Docker host

* Creating new images
	* workflow #1: Start from existing image
	* workflow #2: Define a new image through a Dockerfile

## New Image From Existing One ##

To update an image we first need to create a container from the image we'd like to update.

	$ sudo docker run -t -i training/sinatra /bin/bash
	root@0b2616b0e5a8:/#

Inside our running container let's modify whatever we want.

	# gem install ...
	# apt-get install ...
	# vi newscript.sh

Once this has completed let's exit our container using the exit command.

Execute this command

	$ sudo docker commit -m=<comment> -a=<author> <host_hash> <image_name>:<image_version>

i.e.

	$ sudo docker commit -m="Added json gem" -a="Kate Smith" 0b2616b0e5a8 ouruser/sinatra:v2

## Building an image from a Dockerfile ##

	$ mkdir <image_folder>
	$ cd <image_folder>
	$ touch Dockerfile
	$ sudo docker build -t="<image>" . #i.e. sudo docker build -t="ouruser/sinatra:v2" .

### Dockerfile Syntax ###

	# comment
	<INSTRUCTION> <statement>

-----------------------------------------------------------------------------------------------------------------------
INSTRUCTION  SYNTAX               Support       Description                                          Example
                                  Env
                                  Substitution
-----------  ---------------      ------------  -----------                                          ------------------
FROM         FROM <image>[:<tag>] No            Base image                                           FROM ubuntu:12.04

MAINTAINER   MAINTAINER <author>  No            Image maintainer                                     MAINTAINER Kate Smith <ksmith@example.com>

RUN          RUN <command>        No            the command is run in a shell - /bin/sh -c - 
                                                shell form

RUN          RUN ["executable",   No            
             "param1", "param2"]                

CMD          CMD ["executable",   No            The main purpose of a CMD is to provide defaults 
             "param1","param2"]                 for an executing container.

CMD          CMD [                No            The main purpose of a CMD is to provide defaults 
             "param1","param2"]                 for an executing container.

CMD          CMD command param1   No            The main purpose of a CMD is to provide defaults 
             param2                             for an executing container.

EXPOSE       EXPOSE <port>        Yes           The EXPOSE instructions informs Docker that the 
             [<port>...]                        container will listen on the specified network 
                                                ports at runtime.

ENV          ENV <key> <value>    Yes           Sets the environment variable <key> to the
                                                value <value>

ADD                               Yes           Copies new files, directories or remote file URLs 
                                                from <src> to path <dest>. If <src> is a compressed
                                                file it will be uncompressed.

COPY         COPY <src>... <dest> Yes           copies new files or directories from <src> and 
                                                adds them to the filesystem of the container at 
                                                the path <dest>. <src> MUST not be outside
                                                The folder where Dokerfile is.
                                                If <dest> terminated with "/" it is considered a folder,
						otherwise it's considered a file.

WORKDIR                           Yes           sets the working directory for any RUN, CMD and 
                                                ENTRYPOINT instructions that follow it in the 
                                                Dockerfile

VOLUME                            Yes           Will create a mount point with the specified 
                                                name and mark it as holding externally mounted 
                                                volumes from native host or other containers

USER                              Yes           Sets the user name or UID to use when running 
                                                the image

ENTRYPOINT                        No            An ENTRYPOINT allows you to configure a container 
                                                that will run as an executable.

ONBUILD                           No            Adds to the image a trigger instruction to be 
                                                executed at a later time, when the image is used 
                                                as the base for another build.

* FROM

	FROM		

# i.e. ubuntu:14.04

	RUN 		<commands>	# i.e. apt-get update && apt-get install -y ruby ruby-dev
					# multiple 'RUN' lines could be used for complex provisioning





## Link ##

Docker creates these env variables in the "source" container for each "linked" container.

	<alias>_NAME=/<this_name>/<alias>
	<alias>_PORT_<exposed_port>_<protocol>=<protocol>://<linked_container_ip_address>:<port>
	<alias>_PORT_<exposed_port>_<protocol>_ADDR=<linked_container_ip_address>
	<alias>_PORT_<exposed_port>_<protocol>_PORT=<actual_port>
	<alias>_PORT_<exposed_port>_<protocol>_PROTO=<protocol>

/etc/hosts is also changed

	<this_container_ip>       <this_container_id>
	<linked_container_ip>     <linked_container_alias>




## Managing Data in Containers ##

* Primary ways you can manage data in Docker
	* Data volumes
		* A specially-designated directory within one or more containers that bypasses the Union File System 
		* to provide several useful features for persistent or shared data:
			* Data volumes can be shared and reused between containers
			* Changes to a data volume are made directly
			* Changes to a data volume will not be included when you update an image
			* Volumes persist until no containers use them
		* Can be...
			* a new directory in the container
			* mapped to a directory in the host
			* mapped to a file in the host
	* Data volume containers

* Volumes 
	* decouple 
		* the life of the data being stored in them 
		* from the life of the container that created them. 
	* so you can 
		* docker rm my_container and your data will not be removed.

* A volume can be created in 
	* two ways
		* Specifying VOLUME /some/dir in a Dockerfile
		* Specying it as part of your run command as docker run -v /some/dir
	* Either way, 
		* It tells Docker to create a directory on the host, 
		* within the docker root path (by default /var/lib/docker), 
		* and mount it to the path you've specified (/some/dir above). 
	* When you remove the container using this volume, the volume itself continues to live on.


## Examples ##

### Running an ephemereal Postgres DB ###

Run a postgres instance with

	docker run --rm --name mypg -p 127.0.0.1:5432:5432 -e POSTGRES_PASSWORD=pwd postgres:9.4.0

Connect with a client and execute...

	create table People (
		name varchar(128)
	);
	
	insert into People(name) values('Marco');
	insert into People(name) values('Jean');
	insert into People(name) values('Nikita');

	select * from TEST;

The SELECT return the expected values.
Stop and restart the container, the values are gone.

### Running an persistent Postgres DB ###

If you check with 

	docker inspect 

you will see that postgres defines this volume

	"Volumes": {
		"/var/lib/postgresql/data": "/var/lib/docker/vfs/dir/130b32b8a5187509c4764238a7d7b962f924ba4d52bcbaadca91f994ec30081d"
	},
	"VolumesRW": {
		"/var/lib/postgresql/data": true
	}

So, that means postgres can use volume "/var/lib/postgresql/data" if that is exported by another container.
The special case is when we use a container generated from the same image.

Create an "empty" container

	docker run --name "dbdata" -v /dbdata postgres:9.4.0 echo "data only"

Run a postgres instance with

	docker run --rm --volumes-from dbdata --name mypg -p 127.0.0.1:5432:5432 -e POSTGRES_PASSWORD=pwd postgres:9.4.0

### A Web app ###

A short way to bring up a running ps

	docker run --rm=true -p 5432:5432 --name="temppg" -e POSTGRES_PASSWORD=postgres "postgres:9"


	docker run -d --name="itemsapp_db" postgres


Creates a postgres container

	docker run -d --name="itemsapp_db" postgres

Just to check how the environment in a linking container is set

	docker run --rm --name="itemsapp" --link itemsapp_db:db "myself/mytomcat:0.1" env
	docker run --rm --name="itemsapp" --link itemsapp_db:db "myself/mytomcat:0.1" cat /etc/hosts

Here what we have.

	PATH=/usr/local/tomcat/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
	HOSTNAME=fa3f9b73e652
	DB_PORT=tcp://172.17.0.3:5432
	DB_PORT_5432_TCP=tcp://172.17.0.3:5432
	DB_PORT_5432_TCP_ADDR=172.17.0.3
	DB_PORT_5432_TCP_PORT=5432
	DB_PORT_5432_TCP_PROTO=tcp
	DB_NAME=/itemsapp/db
	DB_ENV_LANG=en_US.utf8
	DB_ENV_PG_MAJOR=9.4
	DB_ENV_PG_VERSION=9.4.0-1.pgdg70+1
	DB_ENV_PGDATA=/var/lib/postgresql/data
	JAVA_VERSION=7u71
	JAVA_DEBIAN_VERSION=7u71-2.5.3-2
	CATALINA_HOME=/usr/local/tomcat
	TOMCAT_MAJOR=8
	TOMCAT_VERSION=8.0.15
	TOMCAT_TGZ_URL=https://www.apache.org/dist/tomcat/tomcat-8/v8.0.15/bin/apache-tomcat-8.0.15.tar.gz
	HOME=/root


## creates an app container 
docker run -d -P --name="itemsapp" --link itemsapp_db:db "myself/mytomcat:0.1"



### A Tomcat Cluster ###

Let's try to set up a Tomcat cluster on two nodes.

First of all, let's decide which base image we would like to use.

	$ docker search tomcat

That gives this list.

	NAME                                  DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
	tomcat                                Apache Tomcat is an open source implementa...   42        [OK]       
	tutum/tomcat                          Tomcat image - listens in port 8080. For t...   37                   [OK]
	consol/tomcat-7.0                     Tomcat 7.0.57, 8080, "admin/admin"              11                   [OK]
	jeanblanchard/busybox-tomcat          Minimal Docker image with Apache Tomcat         8                    [OK]
	...

Let's go for the 'tomcat' machine.


	
Let's see what happens...

	$ docker create --name="tmc1" -P tomcat
	517108c9e06988da99e0ae11d3028bc1fd1cbbfc2ef091d63a531104af232be2

Let's be sure the container exists

	$ docker ps --all
	CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
	517108c9e069        tomcat:latest       "catalina.sh run"   35 seconds ago 

Not let's start it and lets check that happens

	$ docker start tmc1
	$ docker log tmc1
	$ docker ps
	CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
	517108c9e069        tomcat:latest       "catalina.sh run"   3 minutes ago       Up About a minute   0.0.0.0:49155->8080/tcp   tmc1 

Let's start a browser to localhost:49155, it works!
Now, time to fix things.
Let's stop the container. What there is inside ?

	$ sudo docker attach tmc1 # by Name
	$ sudo docker attach 665b4a1e17b6 # by ID
	$ sudo docker exec -i -t tmc1 bash # by Name
	$ sudo docker exec -i -t 517108c9e069 bash # by ID

If we check...

	# cat /usr/local/tomcat/conf/tomcat-users.xml | grep -n3 rolename 

We'll discover that the users are commented out.
So, our first goal is to change the Dockerfile to enable access to the manager app.

	$ docker cp tmc1:/usr/local/tomcat/conf/tomcat-users.xml .

No we can edit in in the host.

	$ vi tomcat-users.xml

Let's add the usual config to make the app available

	<role rolename="manager-gui"/>
	<user username="admin" password="admin" roles="manager-gui" />

Let's start up defining our machines using the Dockerfile.

	$ touch Dockerfile

Let's start with the basic info...

	FROM tomcat
	MAINTAINER Daniele Demichelis <demichelis@danidemi.com>

And let's modify Dockerfile to copy the file

	FROM tomcat
	MAINTAINER Daniele Demichelis <demichelis@danidemi.com>
	COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

Now, let's stop the container, remove it and recreate it from the Dockerfile using "build".

	$ docker stop tmc1
	$ docker rm tmc1
	$ docker build -t="myself/mytomcat:0.1" .
	Sending build context to Docker daemon 18.43 kB
	Sending build context to Docker daemon 
	Step 0 : FROM tomcat
	 ---> fe982f1618dd
	Step 1 : MAINTAINER Daniele Demichelis <demichelis@danidemi.com>
	 ---> Using cache
	 ---> 71a1241dc62e
	Step 2 : COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
	 ---> 1402edcdb559
	Removing intermediate container be629f6c350e
	Successfully built 1402edcdb559
	$ docker create -P --name="tmc1" myself/mytomcat:0.1 




## Under the hood ##

	/var/lib/docker/containers
	└── <full-container-id>
	    ├── 1ee8a5d778cba1738b636183a1e2470fe2699af3a127f50cd012f08dcd47cf4e-json.log
	    ├── config.json
	    ├── hostconfig.json
	    ├── hostname
	    ├── hosts
	    └── resolv.conf

A full-container-id is the real name of a container.
It is shortened to the first 12 chars when reported by tools. i.e.

	full-container-id: 1ee8a5d778cba1738b636183a1e2470fe2699af3a127f50cd012f08dcd47cf4e
	     container-id: 1ee8a5d778cb<------------------ removed ----------------------->

	/var/lib/docker/vfs/dir
		├── <volume-id>
		├── <volume-id>
		├── <volume-id>
		└── <volume-id>





	

## References ##

<https://docs.docker.com/installation/ubuntulinux/>
<https://docs.docker.com/userguide/dockerimages/>
<https://docs.docker.com/reference/builder/>
<https://devopsu.com/blog/docker-misconceptions/>
<http://askubuntu.com/questions/505506/docker-how-to-get-bash-ssh-inside-runned-container-run-d>
<http://www.mulesoft.com/tcat/tomcat-clustering>
<http://crosbymichael.com/dockerfile-best-practices.html>
<https://bryantsai.com/db2-on-docker/>
<http://zeroturnaround.com/rebellabs/docker-for-java-developers-how-to-sandbox-your-app-in-a-clean-environment/>
<https://blog.codecentric.de/en/2014/02/docker-registry-run-private-docker-image-repository/>
<http://www.offermann.us/2013/12/tiny-docker-pieces-loosely-joined.html>
<http://www.tech-d.net/2014/11/18/data-only-container-madness/>
<https://www.martinvanbeurden.nl/blog/cleaning-up-after-docker/>


