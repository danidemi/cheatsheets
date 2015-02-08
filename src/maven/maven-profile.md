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


