## Maven

If you need to use a bare Maven approach, you'll need to set up Maven in order to use the `MANIFEST.MF` you want.
This is because by default, Maven generates its own copy of `MANIFEST.MF` regardless of what 
`MANIFEST.MF` is placed under `src/main/resources`.

Configure Maven to do that is as simple as this...

	<plugins>
		<plugin>
			<groupId>org.apache.maven.plugins</groupId>
			<artifactId>maven-jar-plugin</artifactId>
			<version>2.1</version>

			<configuration>
				<archive>
					<manifestFile>src/main/resources/META-INF/MANIFEST.MF</manifestFile>
				</archive>				
			</configuration>

		</plugin>
	</plugins>


