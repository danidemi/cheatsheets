# Maven Cheat Sheet



## Standard Layout

	src/main/java		Application/Library sources
	src/main/resources	Application/Library resources
	src/main/filters	Resource filter files
	src/main/config		Configuration files
	src/main/scripts	Application/Library scripts
	src/main/webapp		Web application sources
	src/test/java		Test sources
	src/test/resources	Test resources
	src/test/filters	Test resource filter files
	src/it     		Integration Tests (primarily for plugins)
	src/assembly     	Assembly descriptors
	src/site     		Site
	LICENSE.txt     	Project's license
	NOTICE.txt     		Notices and attributions required by libraries that the project depends on
	README.txt     		Project's readme

## META-INF

For jars, `META-INF` should be usually put under `src/main/resources`
For wars, `META-INF` should be usually put under `src/main/webapp`

# Command Line

$ mvn --help

usage: mvn [options] [<goal(s)>] [<phase(s)>]

<table>
  <tr>
    <td>Option</td>
    <td>Explication</td>
    <td>Note</td>
  </tr>
  <tr>
    <td>-am,--also-make</td>
    <td>If project list is specified, also build projects required by the list
</td>
    <td></td>
  </tr>
  <tr>
    <td>-amd,--also-make-dependents        	</td>
    <td>If project list is specified, also
                                    	build projects that depend on
                                    	projects on the list
</td>
    <td></td>
  </tr>
  <tr>
    <td>-B,--batch-mode                    </td>
    <td>Run in non-interactive (batch) mode
</td>
    <td></td>
  </tr>
  <tr>
    <td>-b,--builder <arg>                 </td>
    <td>The id of the build strategy to use.
</td>
    <td></td>
  </tr>
  <tr>
    <td>-C,--strict-checksums              	</td>
    <td>Fail the build if checksums don't
                                    	match
</td>
    <td></td>
  </tr>
  <tr>
    <td>-c,--lax-checksums                 	</td>
    <td>Warn if checksums don't match
</td>
    <td></td>
  </tr>
  <tr>
    <td>-cpu,--check-plugin-updates        	</td>
    <td>Ineffective, only kept for
                                    	backward compatibility
</td>
    <td></td>
  </tr>
  <tr>
    <td>-D,--define <arg>                  	</td>
    <td>Define a system property</td>
    <td>Needed every time a system property like test.skip should pe passed along</td>
  </tr>
  <tr>
    <td>-e,--errors                        	</td>
    <td>Produce execution error messages
</td>
    <td></td>
  </tr>
  <tr>
    <td>-emp,--encrypt-master-password <arg>   </td>
    <td>Encrypt master security password
</td>
    <td></td>
  </tr>
  <tr>
    <td>-ep,--encrypt-password <arg>       	
</td>
    <td>Encrypt server password</td>
    <td></td>
  </tr>
  <tr>
    <td>  -f,--file <arg>                    	
</td>
    <td>Force the use of an alternate POM 	file (or directory with pom.xml).
</td>
    <td></td>
  </tr>
  <tr>
    <td>      -fae,--fail-at-end                 	</td>
    <td>Only fail the build afterwards; allow all non-impacted builds to continue
</td>
    <td></td>
  </tr>
  <tr>
    <td>-ff,--fail-fast                    	</td>
    <td>Stop at first failure in reactorized builds
</td>
    <td></td>
  </tr>
  <tr>
    <td>         -fn,--fail-never                   	</td>
    <td>NEVER fail the build, regardless of project result
</td>
    <td></td>
  </tr>
  <tr>
    <td>   -gs,--global-settings <arg>        	</td>
    <td>Alternate path for the global settings file
</td>
    <td></td>
  </tr>
  <tr>
    <td>-h,--help                          	</td>
    <td>Display help information
</td>
    <td></td>
  </tr>
  <tr>
    <td> -l,--log-file <arg>                	</td>
    <td>Log file to where all build output will go.
</td>
    <td></td>
  </tr>
  <tr>
    <td>-llr,--legacy-local-repository     	
                                    	  
</td>
    <td>Use Maven 2 Legacy Local Repository behaviour, ie no use of _remote.repositories. Can also be activated by using -Dmaven.legacyLocalRepo=true</td>
    <td></td>
  </tr>
  <tr>
    <td>-N,--non-recursive                 	</td>
    <td>Do not recurse into sub-projects
</td>
    <td></td>
  </tr>
  <tr>
    <td>-npr,--no-plugin-registry          	</td>
    <td>Ineffective, only kept for backward compatibility
</td>
    <td></td>
  </tr>
  <tr>
    <td>-npu,--no-plugin-updates           	</td>
    <td>Ineffective, only kept for backward compatibility
</td>
    <td></td>
  </tr>
  <tr>
    <td>-nsu,--no-snapshot-updates         	</td>
    <td>Suppress SNAPSHOT updates
</td>
    <td></td>
  </tr>
  <tr>
    <td>-o,--offline                       	</td>
    <td>Work offline
</td>
    <td></td>
  </tr>
  <tr>
    <td>-P,--activate-profiles <arg>       	</td>
    <td>Comma-delimited list of profiles to activate
</td>
    <td></td>
  </tr>
  <tr>
    <td>-pl,--projects <arg>               	                                    	                                    	

                                    	</td>
    <td>Comma-delimited list of specified reactor projects to build instead of all projects. A project can be specified by [groupId]:artifactId or by its relative path.

</td>
    <td></td>
  </tr>
  <tr>
    <td>-q,--quiet                         	</td>
    <td>Quiet output - only show errors
</td>
    <td></td>
  </tr>
  <tr>
    <td> -rf,--resume-from <arg>            	</td>
    <td>Resume reactor from specified project
</td>
    <td></td>
  </tr>
  <tr>
    <td> -s,--settings <arg>                	</td>
    <td>Alternate path for the user settings file
</td>
    <td></td>
  </tr>
  <tr>
    <td> -T,--threads <arg>                 	
</td>
    <td>Thread count, for instance 2.0C where C is core multiplied</td>
    <td></td>
  </tr>
  <tr>
    <td> -t,--toolchains <arg>              	</td>
    <td>Alternate path for the user toolchains file
</td>
    <td></td>
  </tr>
  <tr>
    <td>-U,--update-snapshots              	
</td>
    <td>Forces a check for missing releases and updated snapshots on
remote repositories</td>
    <td></td>
  </tr>
  <tr>
    <td>-up,--update-plugins               	
</td>
    <td>Ineffective, only kept for backward compatibility</td>
    <td></td>
  </tr>
  <tr>
    <td> -V,--show-version                  	
                                    	
</td>
    <td>Display version information WITHOUT stopping build</td>
    <td></td>
  </tr>
  <tr>
    <td> -v,--version                       	
</td>
    <td>Display version information</td>
    <td></td>
  </tr>
  <tr>
    <td> -X,--debug                         	</td>
    <td>Produce execution debug output
</td>
    <td></td>
  </tr>
</table>


               

## Phases

### Clean Lifecycle

<table>
  <tr>
    <td>pre-clean</td>
    <td>executes processes needed prior to the actual project cleaning</td>
  </tr>
  <tr>
    <td>clean</td>
    <td>remove all files generated by the previous build</td>
  </tr>
  <tr>
    <td>post-clean</td>
    <td>executes processes needed to finalize the project cleaning
</td>
  </tr>
</table>


### Default Lifecycle

<table>
  <tr>
    <td>validate</td>
    <td>validate the project is correct and all necessary information is available.</td>
  </tr>
  <tr>
    <td>initialize</td>
    <td>initialize build state, e.g. set properties or create directories.</td>
  </tr>
  <tr>
    <td>generate-sources</td>
    <td>generate any source code for inclusion in compilation.</td>
  </tr>
  <tr>
    <td>process-sources</td>
    <td>process the source code, for example to filter any values.</td>
  </tr>
  <tr>
    <td>generate-resources</td>
    <td>generate resources for inclusion in the package.</td>
  </tr>
  <tr>
    <td>process-resources</td>
    <td>copy and process the resources into the destination directory, ready for packaging.</td>
  </tr>
  <tr>
    <td>compile</td>
    <td>compile the source code of the project.</td>
  </tr>
  <tr>
    <td>process-classes</td>
    <td>post-process the generated files from compilation, for example to do bytecode enhancement on Java classes.</td>
  </tr>
  <tr>
    <td>generate-test-sources</td>
    <td>generate any test source code for inclusion in compilation.</td>
  </tr>
  <tr>
    <td>process-test-sources</td>
    <td>process the test source code, for example to filter any values.</td>
  </tr>
  <tr>
    <td>generate-test-resources</td>
    <td>create resources for testing.</td>
  </tr>
  <tr>
    <td>process-test-resources</td>
    <td>copy and process the resources into the test destination directory.</td>
  </tr>
  <tr>
    <td>test-compile</td>
    <td>compile the test source code into the test destination directory</td>
  </tr>
  <tr>
    <td>process-test-classes</td>
    <td>post-process the generated files from test compilation, for example to do bytecode enhancement on Java classes. For Maven 2.0.5 and above.</td>
  </tr>
  <tr>
    <td>test</td>
    <td>run tests using a suitable unit testing framework. These tests should not require the code be packaged or deployed.</td>
  </tr>
  <tr>
    <td>prepare-package</td>
    <td>perform any operations necessary to prepare a package before the actual packaging. This often results in an unpacked, processed version of the package. (Maven 2.1 and above)</td>
  </tr>
  <tr>
    <td>package</td>
    <td>take the compiled code and package it in its distributable format, such as a JAR.</td>
  </tr>
  <tr>
    <td>pre-integration-test</td>
    <td>perform actions required before integration tests are executed. This may involve things such as setting up the required environment.</td>
  </tr>
  <tr>
    <td>integration-test</td>
    <td>process and deploy the package if necessary into an environment where integration tests can be run.</td>
  </tr>
  <tr>
    <td>post-integration-test</td>
    <td>perform actions required after integration tests have been executed. This may including cleaning up the environment.</td>
  </tr>
  <tr>
    <td>verify</td>
    <td>run any checks to verify the package is valid and meets quality criteria.</td>
  </tr>
  <tr>
    <td>install</td>
    <td>install the package into the local repository, for use as a dependency in other projects locally.</td>
  </tr>
  <tr>
    <td>deploy</td>
    <td>done in an integration or release environment, copies the final package to the remote repository for sharing with other developers and projects.</td>
  </tr>
</table>


### Site Lifecycle

<table>
  <tr>
    <td>pre-site</td>
    <td>executes processes needed prior to the actual project site generation</td>
  </tr>
  <tr>
    <td>site</td>
    <td>generates the project's site documentation</td>
  </tr>
  <tr>
    <td>post-site</td>
    <td>executes processes needed to finalize the site generation, and to prepare for site deployment</td>
  </tr>
  <tr>
    <td>site-deploy</td>
    <td>deploys the generated site documentation to the specified web server</td>
  </tr>
</table>


## Dependencies

### Package Versions

<major>.<minor>.<incremental>-<qualifier>

-SNAPSHOT

### Declare

<dependencies>

<dependency>

<groupId>{groupId}</groupId>

<artifactId>{artifactId}</artifactId>

<version>{version}</version>

<exclusions>

<exclusion>

		<groupId>{excludedGroupId}</groupId>

<artifactId>{excludedArtifactId}</artifactId>

</exclusion>

</exclusions>

</dependency>

</dependencies>

excludedGroupId:excludedArtifactId won’t be brough in by groupId:artifactId regardless of its deep in the dependnecy tree.

### List All

[http://maven.apache.org/plugins/maven-dependency-plugin/list-mojo.html](http://maven.apache.org/plugins/maven-dependency-plugin/list-mojo.html)

# mvn dependency:list

## List Tree

[http://maven.apache.org/plugins/maven-dependency-plugin/examples/resolving-conflicts-using-the-dependency-tree.html](http://maven.apache.org/plugins/maven-dependency-plugin/examples/resolving-conflicts-using-the-dependency-tree.html)

	$ mvn dependency:tree -Dverbose -Dincludes=commons-collections

## Profiles

### Active Profile

which profile is active

	$ mvn help:active-profiles

## Default Profile And Resources

The ‘default’ profile is active by default. It means that Eclipse will use that, and will include files from env/development in the classpath (see the profile's resource section).

When you want to build the project for a specific environment, through a given profile, remember to provide -Dspecific to disable development. So for instance...

				

	$ mvn assembly:single -Popenshift -Dspecific

				

...will disable this profile during build.  

	<profiles>
   	 <profile>
   		 <id>dev</id>
   		 <!-- This profile is active by default. It means that Eclipse will us
   			 that, and will include files from env/development in the classpath (see this
   			 profile's resource section). When you want to build the project for a specific
   			 environment, through a given profile, remember to provide -Dspecific to disable
   			 development. So for instance... mvn assembly:single -Popenshift -Dspecific
   			 ...will disable this profile during build. -->

   		 <activation>

   			 <activeByDefault>true</activeByDefault>

   			 <property>

   				 <name>!specific</name>

   			 </property>

   		 </activation>

   		 <properties>

   			 <my.environment>dev</my.environment>

   		 </properties>

   		 <build>

   			 <resources>

   				 <resource>

   					 <directory>src/main/resources</directory>

   					 <includes>

   						 <include>**/*</include>

   					 </includes>

   					 <filtering>true</filtering>

   				 </resource>

   				 <resource>

   					 <directory>env/${my.environment}</directory>

   					 <includes>

   						 <include>**/*</include>

   					 </includes>

   					 <filtering>true</filtering>

   				 </resource>

   			 </resources>

   		 </build>

   	 </profile>

   	 <profile>

   		 <id>dockerized</id>

   		 <activation>

   			 <activeByDefault>false</activeByDefault>

   		 </activation>

   		 <properties>

   			 <my.environment>dockerized</my.environment>

   		 </properties>

   	 </profile>

    </profiles>

To build…

	$ mvn build install => uses resources in env/dev

	$ mvn build install -Dspecific -Pdockerized uses resources in /env/dockerized

## Plugins

### General Properties

Lot of plugins share the same properties.

### project.build.sourceEncoding

Encodign for sources and resources.

<properties>

<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>

</properties>

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

mvn help:describe -Dcmd=deploy

mvn help:describe -Dplugin=archetype (here "org.apache." is probably added automatically as usual)

### Versions Plugin

versions:set

Sets the current projects version, updating the details of any child modules as necessary.

versions:commit

If all goes well

versions:rollback

To return to the latest versions

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

Setting a property...

	<properties>
	
	<additionalparam>-Xdoclint:none</additionalparam>
	
	</properties>
	
	or add it to the maven-javadoc-plugin:
	
	<plugins>
	
	    <plugin>
	
	      <groupId>org.apache.maven.plugins</groupId>
	
	      <artifactId>maven-javadoc-plugin</artifactId>
	
	      <configuration>
	
	        <additionalparam>-Xdoclint:none</additionalparam>
	
	      </configuration>
	
	    </plugin>
	
	  </plugins>

# Configurations

## Network Timeouts

[http://maven.apache.org/guides/mini/guide-http-settings.html](http://maven.apache.org/guides/mini/guide-http-settings.html)

[http://stackoverflow.com/questions/23510525/maven-dependency-timeout-settings/27015320#27015320](http://stackoverflow.com/questions/23510525/maven-dependency-timeout-settings/27015320#27015320)

Network timeout can be set on a per server basis.

	<server>
	
	<id>ask-3rdparties</id>
	
		<configuration>
	
			<httpConfiguration>
	
				<all><!-- all | put | get | head -->
	
					<connectionTimeout>5000</connectionTimeout>
	
					<readTimeout>5000</readTimeout>
	
				</all>
	
			</httpConfiguration>
	
		</configuration>
	
	</server>

# Releasing on SOSSRH (Sonatype Open Source Software Repository Hosting Service)

In order to configure Maven to deploy to the OSSRH Nexus server with the Nexus Staging Maven plugin you have to configure it like this

	<distributionManagement>
	
	  <snapshotRepository>
	
		<id>ossrh</id>
	
		<url>https://oss.sonatype.org/content/repositories/snapshots</url>
	
	  </snapshotRepository>
	
	</distributionManagement>
	
	<build>
	
	  <plugins
	
		<plugin>
	
	  	<groupId>org.sonatype.plugins</groupId>
	
	  	<artifactId>nexus-staging-maven-plugin</artifactId>
	
	  	<version>1.6.3</version>
	
	  	<extensions>true</extensions>
	
	  	<configuration>
	
	    	<serverId>ossrh</serverId>
	
	    	<nexusUrl>https://oss.sonatype.org/</nexusUrl>
	
	    	<autoReleaseAfterClose>true</autoReleaseAfterClose>
	
	  	</configuration>
	
		</plugin>
	
		...
	
	  </plugins>
	
	</build>

Since OSSRH is always running the latest available version of Sonatype Nexus Professional, it is best to use the latest version of the Nexus Staging Maven plugin.

## References

[http://ruleoftech.com/2014/distribute-projects-artifacts-in-maven-central-with-ossrh](http://ruleoftech.com/2014/distribute-projects-artifacts-in-maven-central-with-ossrh)

[http://central.sonatype.org/pages/apache-maven.html](http://central.sonatype.org/pages/apache-maven.html)

