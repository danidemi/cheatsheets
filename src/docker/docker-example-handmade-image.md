## Examples: Build An Image Step By Step ##
*or How you can create a reusable Docker image*

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
