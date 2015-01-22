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
		
![Multilayer File System](docker-filesystems-multilayer.png)

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
			
![DockerHub fees on 17 Jan 2015](docker-fees.png "DockerHub fees on 17 Jan 2015")

* Run-by-yourself Docker Hub
	* Docker Hub software is open source
		* https://github.com/docker/docker-registry - current
		* https://github.com/docker/distribution - forthcoming

### Trusted / Automated Builds ###

Automated Builds are a special feature of Docker Hub which allow you to use Docker Hub's build clusters to automatically create images from a specified Dockerfile and a GitHub or Bitbucket repo.
