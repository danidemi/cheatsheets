### Running an persistent Postgres DB ###
*or... How do I separate the life of data folder from life of containers?*

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
