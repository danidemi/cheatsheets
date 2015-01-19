### Running an ephemereal Postgres DB ###
*or... What it means for containers to be ephemereal*

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
