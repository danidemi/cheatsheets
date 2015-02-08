# Releasing on SOSSRH (Sonatype Open Source Software Repository Hosting Service)

* Sonatype OSSRH (OSS Repository Hosting)
	* uses 
		* Sonatype Nexus Professional 
	* to provide 
		* repository hosting service 
	* for open source project binaries
	* allows you to
		* deploy development version binaries (snapshots)
		* stage release binaries
		* promote release binaries and sync them to the Central Repository


To configure Maven to deploy to the OSSRH Nexus server with the Nexus Staging Maven plugin 
you have to configure the project pom.xml it like this:


~~~~~~~~~~~~~~~~~~~~~~~~~
<distributionManagement>
	<snapshotRepository>
		<id>ossrh</id>
		<url>https://oss.sonatype.org/content/repositories/snapshots</url>
	</snapshotRepository>
</distributionManagement>	
<build>
	<plugins>
		<plugin>
			<groupId>org.sonatype.plugins</groupId>
			<artifactId>nexus-staging-maven-plugin</artifactId>
			<version>1.6.3</version><-- Or RELEASE -->
			<extensions>true</extensions>
			<configuration>
				<serverId>ossrh</serverId>
				<nexusUrl>https://oss.sonatype.org/</nexusUrl>
				<autoReleaseAfterClose>true</autoReleaseAfterClose>
			</configuration>
		</plugin>	
	  </plugins>	
</build>
~~~~~~~~~~~~~~~~~~~~~~~~~

Since OSSRH is always running the latest available version of Sonatype Nexus Professional, 
it is best to use the latest version of the Nexus Staging Maven plugin.

To get Javadoc and Source jar files generated, you have to configure the javadoc and source Maven plugins.

~~~~~~~~~~~~~~~~~~~~~~~~~
<build>
	<plugins>
		<plugin>
			<groupId>org.apache.maven.plugins</groupId>
			<artifactId>maven-source-plugin</artifactId>
			<version>2.2.1</version>
			<executions>
				<execution>
					<id>attach-sources</id>
					<goals>
						<goal>jar-no-fork</goal>
					</goals>
				</execution>
			</executions>
		</plugin>
		<plugin>
			<groupId>org.apache.maven.plugins</groupId>
			<artifactId>maven-javadoc-plugin</artifactId>
			<version>2.9.1</version>
			<executions>
				<execution>
					<id>attach-javadocs</id>
					<goals>
						<goal>jar</goal>
					</goals>
				</execution>
			</executions>
		</plugin>
	</plugins>
</build>
~~~~~~~~~~~~~~~~~~~~~~~~~

The Maven GPG plugin is used to sign the components with the following configuration.

~~~~~~~~~~~~~~~~~~~~~~~~~
<build>
	<plugins>
		<plugin>
			<groupId>org.apache.maven.plugins</groupId>
			<artifactId>maven-gpg-plugin</artifactId>
			<version>1.5</version>
			<executions>
				<execution>
					<id>sign-artifacts</id>
					<phase>verify</phase>
					<goals>
						<goal>sign</goal>
					</goals>
				</execution>
			</executions>
		</plugin>
	</plugins>
</build>
~~~~~~~~~~~~~~~~~~~~~~~~~

The Nexus Staging Maven Plugin is the recommended way to deploy your components to OSSRH and release them to the Central Repository. To configure it simply add the plugin to your Maven pom.xml.

~~~~~~~~~~~~~~~~~~~~~~~~~
<build>
	<plugins>
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
	</plugins>
</build>
~~~~~~~~~~~~~~~~~~~~~~~~~

Using a profile

Since the generation of the javadoc and source jars as well as signing components 
with GPG is a fairly time consuming process, these executions are typically isolated 
from the normal build configuration and moved into a profile. 
This profile is then in turn used when a deployment is performed by activating the profile.

~~~~~~~~~~~~~~~~~~~~~~~~~
<profiles>
	<profile> 
		<id>release</id>
		<build>
			<!--javadoc, source and gpg plugin from above-->
		</build>
	</profile>
</profiles>
~~~~~~~~~~~~~~~~~~~~~~~~~

Performing a Snapshot Deployment

	$ mvn clean deploy
	
Performing a Release Deployment

If your version is a release version (does not end in -SNAPSHOT) and with this setup in place, 
you can run a deployment to OSSRH and an automated release to the Central Repository with the usual:

	$ mvn versions:set -DnewVersion=1.2.3
	$ mvn clean deploy -P release

