## Fuse

* Red Hat JBoss Development Studio
* ⁠JDK 1.6
	* see the Red Hat JBoss Fuse Supported Configurations page for details.
* ⁠Apache Maven
	* recommended Apache Maven version >3.0.x
* ⁠Red Hat JBoss Fuse Tooling
T	he JBoss Fuse Tooling provides a set of developer tools for developing Red Hat JBoss Fuse applications within Red Hat JBoss Development Studio. 
	Using JBoss Fuse Tooling, you can 
	* connect and configure Enterprise Integration Patterns to build routes, 
	* browse endpoints and routes, 
	* drag and drop messages onto running routes, 
	* trace message flows, 
	* edit running routes, 
	* browse and visualize runtime processes via JMX, 
	* and deploy your project's code to 
		* Red Hat JBoss Fuse and Fabric8 containers, 
		* to Apache ServiceMix, 
		* and to Apache Karaf. 

* JBoss Fuse has built-in support for two dependency injection frameworks: 
	* Spring XML and 
	* Blueprint XML

* JBoss can be deployed as
	* as an OSGi bundle, 
		* `META-INF/MANIFEST.MF` The JAR manifest can be used to provide deployment metadata either for an OSGi bundle (in bundle headers)
	* as Fuse Application Bundle(FAB), 
		* `META-INF/MANIFEST.MF` The JAR manifest can be used to provide deployment metadata either for FAB
		* `META-INF/maven/groupId/artifactId/pom.xml` The POM file—which is normally embedded in any Maven-built JAR file—is the main source of deployment metadata for a FAB.
	* or a WAR
		* `WEB-INF/web.xml` The web.xml file is the standard descriptor for an application packaged as a Web ARchive (WAR).


* Apache ServiceMix is a 
	* flexible, 
	* open-source 
	* integration container 
	* that unifies the features and functionality of 
		* Apache ActiveMQ, 
		* Camel, 
		* CXF, 
		* and Karaf 
	* into a powerful runtime platform you can use to build your own integrations solutions. 
	* It provides a complete, enterprise ready ESB exclusively powered by OSGi.

## Features

### Feature

An OSGi bundle is not a convenient unit of deployment to use with the Red Hat JBoss Fuse container. 
Applications typically consist of multiple OSGi bundles and complex applications may consist of a very large number of bundles. 
Usually, you want to deploy or undeploy multiple OSGi bundles at the same time and you need a deployment mechanism that supports this.
Apache Karaf _features_ are designed to address this problem. 
A feature is essentially a way of aggregating multiple OSGi bundles into a single unit of deployment. 
When defined as a feature, you can simultaneously deploy or undeploy a whole collection of bundles.
⁠
What to put in a feature
At a minimum, a feature should contain the basic collection of OSGi bundles that make up the core of your application. 
In addition, you might need to specify some of the dependencies of your application bundles, 
in case those bundles are not predeployed in the container.

