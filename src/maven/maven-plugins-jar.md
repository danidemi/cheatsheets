# Jar Plugin

You can change the name of the produced jar.


	<plugin>
		<groupId>org.apache.maven.plugins</groupId>
		<artifactId>maven-jar-plugin</artifactId>
		<version>2.3.2</version>
		<configuration>
			<finalName>${project.artifactId}</finalName>
		</configuration>
	</plugin>      
