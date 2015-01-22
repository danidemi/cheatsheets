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

