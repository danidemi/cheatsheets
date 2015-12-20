## Plugins

### General Properties

Lot of plugins share the same properties.

### project.build.sourceEncoding

Encodign for sources and resources.

	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
	</properties>


### Jar Plugin

You can change the name of the produced jar.


	<plugin>
		<groupId>org.apache.maven.plugins</groupId>
		<artifactId>maven-jar-plugin</artifactId>
		<version>2.3.2</version>
		<configuration>
			<finalName>${project.artifactId}</finalName>
		</configuration>
	</plugin>      


### Compiler Plugin

	<plugin>
		<groupId>org.apache.maven.plugins</groupId>
		<artifactId>maven-compiler-plugin</artifactId>
		<version>2.3.1</version>
		<configuration>
			<source>1.6</source>
			<target>1.6</target>
		</configuration>
	</plugin>

### Archetype Plugin

[http://maven.apache.org/guides/introduction/introduction-to-archetypes.html](http://maven.apache.org/guides/introduction/introduction-to-archetypes.html)

Scaffold a project based on a "template" called archetype.

	archetype:generate > /tmp/archetype.txt

Store the list of available archetypes in a file, there are 1200+ of them.

	archetype:generate -DarchetypeArtifactId=maven-archetype-quickstart

Generate a quickstart maven project

#### Useful Archetypes

org.apache.maven.archetypes:maven-archetype-quickstart: An archetype which contains a sample Maven project.

### Help Plugin

[http://maven.apache.org/plugins/maven-help-plugin/](http://maven.apache.org/plugins/maven-help-plugin/)

	help:effective-pom

The effective pom, with dependencies from parent among other things.

	help:describe

Describe a plugin, a mvn command, etc... 
Here "org.apache." is probably added automatically as usual if not specified.

	mvn help:describe -Dcmd=deploy

	mvn help:describe -Dplugin=archetype 
	


### Versions Plugin

Sets the current projects version, updating the details of any child modules as necessary.

	versions:set

If all goes well you have to "commit" the modifications...

	versions:commit

...or refuse them to return to the latest versions.

	versions:rollback


#### References

<http://mojo.codehaus.org/versions-maven-plugin>

### Assembly Plugin

	<plugin>
	<artifactId>maven-assembly-plugin</artifactId>
	<version>2.5.2</version>
	<executions>
		<execution>
			<id>targz-assembly</id>
			<phase>package</phase>
			<goals>
				<goal>single</goal>
			</goals>
			<configuration>
				<descriptors>
					<descriptor>src/assembly/assembly.xml</descriptor>
				</descriptors>
			</configuration>						
		</execution>
	</executions>
	</plugin>

binds the building of the assembly to the package phase, so...

	$ mvn package

...should be enough to build the distributable havin the project itself in the libraries.

### Descriptor

	<assembly 
		xmlns="http://maven.apache.org/plugins/maven-assembly-plugin/assembly/1.1.2" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	  	xsi:schemaLocation="
	  		http://maven.apache.org/plugins/maven-assembly-plugin/assembly/1.1.2 
	  		[http://maven.apache.org/xsd/assembly-1.1.2.xsd](http://maven.apache.org/xsd/assembly-1.1.2.xsd)">
		<id>default</id>	
		<formats>
			<format>tar.gz</format>
		</formats>
		<!-- name of the folder the archive will be expanded to -->
		<baseDirectory>Oracle.GFP</baseDirectory>
		<moduleSets>
			<!-- where project jar will be copied to -->	
			<moduleSet>
				<binaries>
					<outputDirectory>lib</outputDirectory>
				</binaries>
			</moduleSet>
		</moduleSets>
	
		
	
		<dependencySets>	
			<!-- where dependencies will be copied to -->
			<dependencySet>
				<useProjectArtifact>true</useProjectArtifact>
				<outputDirectory>lib</outputDirectory>
			</dependencySet>
		</dependencySets>
	
		
	
		<fileSets>
			<!-- copies scritps -->
			<fileSet>
				<directory>src/main/scripts</directory>
				<outputDirectory>/</outputDirectory>
				<fileMode>0744</fileMode>
			</fileSet>
	
			
	
			<!-- copy the environmental configuration files -->
			<fileSet>
				<directory>${basedir}/env/${my.environment}</directory>
				<outputDirectory>/conf</outputDirectory>
				<includes>
					<include>*.xml</include>
				</includes>			
			</fileSet>
			<!-- This is just a trick to create an empty ‘log’ folder -->
			<!-- assembly.xml can only create folders if you copy something →
	<!-- existing in them -->
	
			<fileSet>
	
				<directory>${basedir}/src/main/resources</directory>
	
				<outputDirectory>/log</outputDirectory>
	
				<excludes>
	
					<exclude>*/**</exclude>
	
				</excludes>
	
			</fileSet>
	
		</fileSets>
	
	</assembly>

#### References

* [http://stackoverflow.com/questions/14276453/maven-assembly-include-the-current-project-jar-in-the-final-zip-tar](http://stackoverflow.com/questions/14276453/maven-assembly-include-the-current-project-jar-in-the-final-zip-tar)

* [http://maven.apache.org/plugins/maven-assembly-plugin/assembly.html#class_fileSet](http://maven.apache.org/plugins/maven-assembly-plugin/assembly.html#class_fileSet)

### Site Plugin

* site:site 

    * is used generate a site for a **single project**. Note that links between module sites in a multi module build will not work, since local build directory structure doesn't match deployed site.

* site:deploy 

    * is used to deploy the generated site using Wagon supported protocol to the site URL specified in the <distributionManagement> section of the POM.

* site:run 

    * starts the site up, rendering documents as requested for faster editing. It uses Jetty as the web server.

* site:stage 

    * generates a site in a local staging or mock directory based on the site URL specified in the <distributionManagement> section of the POM. It can be used to test that links between module sites in a multi module build works. To preview the whole tree of a multi-module site, you can use the[ site:stage](http://maven.apache.org/plugins/maven-site-plugin/stage-mojo.html) goal. This will copy individual sites to their proper place at the staging location.

* site:stage-deploy 

    * deploys the generated site to a staging or mock directory to the site URL specified in the <distributionManagement> section of the POM.

* site:attach-descriptor 

    * adds the site descriptor (site.xml) to the list of files to be installed/deployed. For more references of the site descriptor, here's a link.

* site:jar 

    * bundles the site output into a JAR so that it can be deployed to a repository.

* site:effective-site 

    * calculates the effective site descriptor, after inheritance and interpolation.

### Javadoc Plugin

	<project>
	
	  ...
	
	  <reporting>
	
	    <plugins>
	
	      <plugin>
	
	        <groupId>org.apache.maven.plugins</groupId>
	
	        <artifactId>maven-javadoc-plugin</artifactId>
	
	        <version>2.10.1</version>
	
	        <configuration>
	
	          ...
	
	        </configuration>
	
	      </plugin>
	
	    </plugins>
	
	    ...
	
	  </reporting>
	
	  ...
	
	</project>

### JDK 8, old projects

Old projects have probably javadoc comments that are not very well accepted by JDK8’s javadoc tool, namely ‘doclint’.

If you keep on receiving ERRORs about javadoc comments during the build process, try to disable ‘doclint’

#### Base Approach

Setting a property...

	<properties>
	
	<additionalparam>-Xdoclint:none</additionalparam>
	
	</properties>
	
or add it to the maven-javadoc-plugin:
	
	<?xml version="1.0" encoding="UTF-8"?>
	<plugins>
	  <plugin>
	    <groupId>org.apache.maven.plugins</groupId>
	    <artifactId>maven-javadoc-plugin</artifactId>
	    <configuration>
	      <additionalparam>-Xdoclint:none</additionalparam>
	    </configuration>
	  </plugin>
	</plugins>

#### Profile Apporach based on profiles

This seems a better approach. Define a profile that will disable the strict checks from doclint on JDK >= 1.8

	<profiles>
	  <profile>
	    <id>doclint-java8-disable</id>
	    <activation>
	      <jdk>[1.8,)</jdk>
	    </activation>
	    <properties>
	      <javadoc.opts>-Xdoclint:none</javadoc.opts>
	    </properties>
	  </profile>
	</profiles>

And then twaek the plugin to pass the parameter.

	<build>
	  <plugins>
	    <plugin>
	      <groupId>org.apache.maven.plugins</groupId>
	      <artifactId>maven-javadoc-plugin</artifactId>
	      <version>2.9.1</version>
	      <executions>
		<execution>
		  <id>attach-javadocs</id>
		  <configuration>
		    <additionalparam>${javadoc.opts}</additionalparam>
		  </configuration>
		</execution>
	      </executions>
	    </plugin>
	    ...
	  </plugins>
	</build>
