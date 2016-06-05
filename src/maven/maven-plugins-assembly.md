# Assembly Plugin

## Example: Bound Assembly To 'package' Phase

Binds the building of the assembly to the package phase.

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

				    <!-- true to append the id to the produced file name -->
				    <appendAssemblyId>false</appendAssemblyId>

			    </configuration>
		    </execution>
	    </executions>
	</plugin>

So...

	$ mvn package

...should be enough to build the distributable having the project itself in the libraries.

# Descriptor

Here's a sample of an assembly descriptor

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
		<baseDirectory>app-dir</baseDirectory>
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
			<!-- assembly.xml can only create folders if you copy something existing in them -->
			<fileSet>
				<directory>${basedir}/src/main/resources</directory>
				<outputDirectory>/log</outputDirectory>
				<excludes>
					<exclude>*/**</exclude>
				</excludes>
			</fileSet>

            <!-- section for single files -->
            <files>
                <!-- single file -->
                <file>
                    <source>src/main/common/server.xml</source>
                    <outputDirectory>app1</outputDirectory>
                </file>
            </files>
	
		</fileSets>
	
	</assembly>

#### References

* [http://stackoverflow.com/questions/14276453/maven-assembly-include-the-current-project-jar-in-the-final-zip-tar](http://stackoverflow.com/questions/14276453/maven-assembly-include-the-current-project-jar-in-the-final-zip-tar)

* [http://maven.apache.org/plugins/maven-assembly-plugin/assembly.html#class_fileSet](http://maven.apache.org/plugins/maven-assembly-plugin/assembly.html#class_fileSet)

