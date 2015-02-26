## Maven

Just create a simple project with packaging jar.

	<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
		<modelVersion>4.0.0</modelVersion>
		<groupId>com.danidemi</groupId>
		<artifactId>com.danidemi.tutorial-osgi</artifactId>
		<version>0.0.1-SNAPSHOT</version>
		<packaging>jar</packaging>

		<dependencies>
			<dependency>
				<groupId>org.osgi</groupId>
				<artifactId>org.osgi.core</artifactId>
				<version>6.0.0</version>
			</dependency>
		</dependencies>
	</project>

Add this class.

	package com.danidemi.osgitutorial;

	import org.osgi.framework.BundleActivator;
	import org.osgi.framework.BundleContext;
	import org.osgi.framework.ServiceEvent;
	import org.osgi.framework.ServiceListener;

	/**
	 * This class implements a simple bundle that utilizes the OSGi
	 * framework's event mechanism to listen for service events. Upon
	 * receiving a service event, it prints out the event's details.
	**/
	public class Activator implements BundleActivator, ServiceListener
	{
		// methods
	}

Compile with maven

	# mvn clean install

Start Felix Gogo

	!g start 

## References

<http://books.sonatype.com/mcookbook/reference/sect-osgi-generate-project.html>
<http://felix.apache.org/site/apache-felix-tutorial-example-1.html>
