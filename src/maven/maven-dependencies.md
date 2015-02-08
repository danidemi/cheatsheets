## Dependencies

### Package Versions

The exact version

	<version><major>.<minor>.<incremental></version>
	
The latest snapshot of the given version

	<version><major>.<minor>.<incremental>-SNAPSHOT</version>
		
Declare an exact version.

	<version>[1.0.1]</version>

Declare an explicit version, will always resolve to 1.0.1 unless a collision occurs, 
when Maven will select a matching version.

	<version>1.0.1</version>

Use any version that 1.0.0 <= version < 2.0.0, i.e: 1.9.9

	<version>[1.0.0,2.0.0)</version>

Declare an open-ended version, i.e: 4.3.2, but not 0.4.4

	<version>[1.0.0,)</version>

### Available up to Maven 2.x	
	
LATEST refers to the latest released or snapshot version of a particular artifact, the most recently deployed artifact in a particular repository.

	<version>LATEST</version>

RELEASE refers to the last non-snapshot release in the repository.

	<version>RELEASE</version>	


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

	$ mvn dependency:list

## List Tree

[http://maven.apache.org/plugins/maven-dependency-plugin/examples/resolving-conflicts-using-the-dependency-tree.html](http://maven.apache.org/plugins/maven-dependency-plugin/examples/resolving-conflicts-using-the-dependency-tree.html)

	$ mvn dependency:tree -Dverbose -Dincludes=commons-collections


