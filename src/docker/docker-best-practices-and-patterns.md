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



