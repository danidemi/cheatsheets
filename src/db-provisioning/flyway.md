## Flyway

http://flywaydb.org/

### Installation

#### Maven

	<dependency>
		<groupId>org.flywaydb</groupId>
		<artifactId>flyway-core</artifactId>
		<version>3.0</version>
	</dependency>

#### Spring XML

Ensure "flyway" bean to be instantiated *after* "your_datasource", using depends.


	<bean id="flyway" class="org.flywaydb.core.Flyway" init-method="migrate">
		<property name="dataSource" ref="your_datasource"/>
		<property name="locations" value="migrations_location" />        
	</bean>

#### Migrations

Automatically discover migrations in the classpath. 
Advised classpath is `/db/migrations`
Each file contains one migration.
Name of migration files have to obey the pattern `V{version}__{desc}.sql`

	{version} could be: <numeric><.|_><numeric><.|_><numeric>

[SqlMigrationNaming.png]

Examples
* V1.1.1__create_user_table.sql
	
