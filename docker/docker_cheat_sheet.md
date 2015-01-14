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

* With Docker you can: 
	* run applications that have been previously dockerized
		* in comlpete isolation (a.k.a. "Container")
			* more or less as it would happen with a VM
		* withouth the burden of sysop
			* at some extent
	* be sure that container will be the same regardless of the environment they are run in
		* because they can be created as instances of immutable "Images"
	* setuplessly link containers
		* i.e.
			* run container#1 with a web appication
			* run container#2 with the db needed by the web app
		* applications should be built to work together (a.k.a. "dockerization")
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

* Docker Platform is made up by
	* Docker Engine
		* a portable 
		* lightweight 
		* runtime
	* Packaging Tool
	* Docker Hub 
		* a cloud service for 
			* sharing Images of dockerized applications
			* automating workflows

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
				* allow independent containers to run within a single Linux instance
		* union mount to provide the Union File System

* Docker runs processes in isolated containers. 
	* When an operator executes docker run, she starts a process with 
		* its own file system
		* its own networking
		* its own isolated process tree 
	* The Image which starts the process may 
		* define defaults 
			* related to the binary to run 
			* the networking to expose
			* ...
		* can be usually overridden when container is started.

* By default container's file system persists after the container exits. 
	* Easier debugging 
	* Data are retained.
	* It consume some space if you are not aware of it.

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

### Trusted / Automated Builds ###

Automated Builds are a special feature of Docker Hub which allow you to use Docker Hub's build clusters to automatically create images from a specified Dockerfile and a GitHub or Bitbucket repo.

## Closer Look

### Docker Engine ###

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

### Images ###

* Docker images are the basis of containers
* If an image isn't already present on the host then it'll be downloaded from a registry
	* by default the Docker Hub Registry
* Docker stores downloaded images on the Docker host

* Creating new images
	* workflow #1: Start from existing image
	* workflow #2: Define a new image through a Dockerfile

### Networking ###

By default, every time a container is restarted, it binds to different host ports.

### Container Linking ###

Docker creates these env variables in the "source" container for each "linked" container.

	<alias>_NAME=/<this_name>/<alias>
	<alias>_PORT_<exposed_port>_<protocol>=<protocol>://<linked_container_ip_address>:<port>
	<alias>_PORT_<exposed_port>_<protocol>_ADDR=<linked_container_ip_address>
	<alias>_PORT_<exposed_port>_<protocol>_PORT=<actual_port>
	<alias>_PORT_<exposed_port>_<protocol>_PROTO=<protocol>

/etc/hosts is also changed

	<this_container_ip>       <this_container_id>
	<linked_container_ip>     <linked_container_alias>

### Volumes ###

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
















## Docker CLI ##

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





### Dockerfile ###

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

	FROM		# i.e. ubuntu:14.04

	RUN 		<commands>	# i.e. apt-get update && apt-get install -y ruby ruby-dev
					# multiple 'RUN' lines could be used for complex provisioning






## Best practices & pattern ##

### General ###

#### Be repeatable ####

Main goal is to be able to create the very same container whenever you need it.

#### Be portable ####

Main goal is to be able to run the very same container on different platforms.

#### Don't boot init ####

* Containers model processes not machines
* The goal is that you only run one process per container 
* So an init or supervisor is not needed. 
* If the processes dies inside a container then the container dies
* Instead of restarting the process just restart the same container or a new container

### Images ###

#### Don't upgrade in builds ####

* Updates will be baked into the based images you don't need to apt-get upgrade your containers.
* If there are security updates that a base image needs, 
let upstream know so that they can update it for everyone and ensure that your builds are consistent again.
* so 
	* best case you run an upgrade in a build and it works. 
	* worse case a pkg tries to mount, etc and it fails. 
* you should bake security fixes into the base images and rebuild on top of them so that the end result is consistent. 
* The end goal is that the image i build today is the same image that will be built tomorrow unless i explicitly say otherwise.

#### Use small base images ####

Some images are more bloated than others. I suggest using debian:jessie as your base.

#### Use specific tags ####

##### Use specific tags when specifying FROM images #####

This is important for your base images. 
Your FROM should always contain the full repository and tag for the base image that you are depending on. 
FROM debian:jessie not just FROM debian

##### Use specific tags for your images #####

Unless you are experimenting with docker you should always pass the -t option to docker build so that the resulting image is tagged. 
A simple human readable tag will help you manage what each image was created for.

	docker build -t="crosbymichael/sentry" .

Always pass -t to tag the resulting image.

#### Use the cache ####

Keep common instructions at the top of the Dockerfile to utilize the cache.

Each instruction in a Dockerfile commits the change into a new image which will then be used as the base of the next instruction. 
If an image exists with the same parent and instruction ( except for ADD ) docker will use the image instead of executing the instruction, i.e. the cache.

### Dockerfile ###

#### EXPOSE-ing ports ####

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

#### CMD and ENTRYPOINT syntax ####

Always use the array syntax.

### Dockerized App ###

#### Log to stdout ####

The docker logs command looks inside the container and returns its standard output.
So, log to stdout to make logs available to the client.






















## Examples ##

### Build An Image Step By Step ###
#### or How you can create a reusable Docker image ####

#### Goal ####

To create an image performing common operations.

#### Instructions ####

The goal is to build a dockerized image of postgresql-client, the CLI Postgres client, that will allow us to interact with a container running postgres.

Let's start a container based on ubuntu

	$ docker run -it ubuntu:14.04 

Once inside the container let's check psql is not installed.

	# psql -V

let's run apt-get. We don't need to use sudo becasue we're root.

	# apt-get install postgresql-client

psql is now available

	# psql -V

exit form the container

	# exit

check the name of the container

	# docker ps -a

in my case the name is "focused_mccharty"

	$ docker commit -m="Added psql" -a="Daniele" focused_mccharty mine/psql:0.1

check that the new image is available

	$ docker images

try to run a temprary container running psql with

	$ docker run -ti --rm mine/psql:0.1

you will be able to run that whenever you want without the need to reintall psql

#### Conclusion ####

Images are a good way to have a reproducibile, disposable application based on a container.


### Container private data ###

#### Goal

To show where a container puts its private data

#### Instructions

Just check what is inside Docker's system directories

	$ sudo tree -L 3 /var/lib/docker/containers; \
	sudo tree -L 3 /var/lib/docker/volumes; \
	sudo tree -L 3 /var/lib/docker/vfs 

The result depends on if and how you previously run docker. This time on my machine the folders are empty. 

	/var/lib/docker/containers

	0 directories, 0 files
	/var/lib/docker/volumes

	0 directories, 0 files
	/var/lib/docker/vfs
	└── dir

	1 directory, 0 files

Run a postgres instance with

	docker run --rm --name mypg -p 127.0.0.1:5432:5432 -e POSTGRES_PASSWORD=pwd postgres:9.4.0

While container is running check again for the folders.

	/var/lib/docker/containers
	└── 6e556aa9af283a15f0960352bf4277eec74722d03a3aca37722e9976145589c0
	    ├── 6e556aa9af283a15f0960352bf4277eec74722d03a3aca37722e9976145589c0-json.log
	    ├── config.json
	    ├── hostconfig.json
	    ├── hostname
	    ├── hosts
	    └── resolv.conf

	1 directory, 6 files
	/var/lib/docker/volumes
	└── 605d94e8be0d21fb3b8816b2dcf10dcc714ccb90f1d964f1c75bc9dc322c608d
	    └── config.json

	1 directory, 1 file
	/var/lib/docker/vfs
	└── dir
	    └── 605d94e8be0d21fb3b8816b2dcf10dcc714ccb90f1d964f1c75bc9dc322c608d
		├── base
		├── global
		├── pg_clog
		├── pg_dynshmem
		├── pg_hba.conf
		├── pg_ident.conf
		├── pg_logical
		├── pg_multixact
		├── pg_notify
		├── pg_replslot
		├── pg_serial
		├── pg_snapshots
		├── pg_stat
		├── pg_stat_tmp
		├── pg_subtrans
		├── pg_tblspc
		├── pg_twophase
		├── PG_VERSION
		├── pg_xlog
		├── postgresql.auto.conf
		├── postgresql.conf
		├── postmaster.opts
		└── postmaster.pid

Stop the container <CTRL+C>

Check again in the folders.

	/var/lib/docker/containers

	0 directories, 0 files
	/var/lib/docker/volumes

	0 directories, 0 files
	/var/lib/docker/vfs
	└── dir

	1 directory, 0 files

#### Conclusion

run --rm allows to play around with a container removing all its data when it terminates.


### Running an ephemereal Postgres DB ###
####or... What it means for containers to be ephemereal####

#### Goal

To show what are the implications for containers to be ephemeral

#### Instructions

Start a Postgres instance with

	$ docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=pwd postgres:9.4.0

Docker outputs the new container id

	9b204a60da31a39dc1cb6b4ad944aa75ecb53e6bd069dfe726e604bf3ec37715

Check the IP of the new container. You can use the first 12 chars as name.

	$ docker inspect 9b204a60da31 | grep -i ipaddress
	"IPAddress": "172.17.0.11",

Connect to the DB with a new container that runs plsql 

	$ docker run -ti --rm mine/psql:0.1 psql -h 172.17.0.11 -p 5432 -U postgres postgres

a client and execute...

	postgres=# create table people (name varchar(128));
	postgres=# insert into People(name) values('susie'),('vivianne'),('axelle');
	postgres=# select * from people;

The SELECT returns the expected values. 

Stop the postgres container

	$ docker stop 9b204a60da31

#### Conclusions ####

Now, repeat the process and you'll find that the modifications on the Db have not been kept. This is because run always create a new container. If you to restart the same container with restart, it will start at different address, but the data will still be there. Data are actually removed in only two ways:
	
* docker run --rm
	* when the container exits
* docker rm -v <container>

### Running an persistent Postgres DB ###
####or... How do I separate the life of data folder from life of containers?####

#### Goal ####
Understand how one can remove container keeping its data. Or for instance keep the database data and upgrade from postgres 9:3 to postgres 9:4.


#### Instrutions ####
If you check the *postgres* Image  [instructions](https://registry.hub.docker.com/_/postgres/) you will see that the image has been configured to store data in */var/lib/postgresql/data/*.

If you check with 

	$ docker inspect <postgresql-container>  | grep -n 3 -i volumes 

you will see that postgres defines this volume...

	"Volumes": {
		"/var/lib/postgresql/data": "/var/lib/docker/vfs/dir/130b32b8a5187509c4764238a7d7b962f924ba4d52bcbaadca91f994ec30081d"
	},
	"VolumesRW": {
		"/var/lib/postgresql/data": true
	}

So, that means postgres allows its folder */var/lib/postgresql/data* to be *imported* into another container.
Create container that immediately terminates.

	docker run --name "dbdata" -v /dbdata postgres:9.4.0 true

Run a postgres instance with

	docker run --rm --volumes-from dbdata --name mypg -p 5432:5432 -e POSTGRES_PASSWORD=pwd postgres:9.4.0

#### Conclusions ####

Container *mypg* will import */var/lib/postgresql/data* from *dbdata* into its filesystem. There is a name conflict but imported volumes take precedence on local filesystem entries. This way data are kept into the "data" container and it is possible to upgrade the container.

### A Web app ###
#### or How do I dockerize my own Java web app ? ####

#### Goal ####
Shows how a JEE app can be dockerized.

#### Instructions ####

Creates a postgres container

	$ docker run -d --name="itemsapp_db" postgres

Check how the environment in a linking container is set

	$ docker run --rm --name="itemsapp" --link itemsapp_db:db "myself/mytomcat:0.1" env

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

Check how the hosts file is set

	$ docker run --rm --name="itemsapp" --link itemsapp_db:db "myself/mytomcat:0.1" cat /etc/hosts

Creates an app container

	$ docker run -d -P --name="itemsapp" --link itemsapp_db:db "myself/mytomcat:0.1"



### A Tomcat Based Image ###
#### or How do I build an Image running Tomcat ? ####

#### Goal ####
To show how can you leverage prebuilt Images to setup an application differently

#### Instructions ####
First of all, let's decide which base image we would like to use.

	$ docker search tomcat

That gives this list.

	NAME                                  DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
	tomcat                                Apache Tomcat is an open source implementa...   42        [OK]       
	tutum/tomcat                          Tomcat image - listens in port 8080. For t...   37                   [OK]
	consol/tomcat-7.0                     Tomcat 7.0.57, 8080, "admin/admin"              11                   [OK]
	jeanblanchard/busybox-tomcat          Minimal Docker image with Apache Tomcat         8                    [OK]
	...

Let's go for the 'tomcat' machine. Let's try to run it just to check what it does...

	$ docker run --rm --name="tmc1" -P tomcat
	517108c9e06988da99e0ae11d3028bc1fd1cbbfc2ef091d63a531104af232be2

Ler's tetrieve some info using ps

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
So, our first goal is to create an image that enable access to the manager app.

Let's copy a file out of the container filesystem into the local filesystem.

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


