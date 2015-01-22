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
