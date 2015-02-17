## Spring Jdbc Utils

### XML Preamble

<?xml version="1.0" encoding="UTF-8"?>
	<beans 
		xmlns="http://www.springframework.org/schema/beans" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
		xmlns:jdbc="http://www.springframework.org/schema/jdbc" 
		xsi:schemaLocation="
			http://www.springframework.org/schema/beans
			http://www.springframework.org/schema/beans/spring-beans.xsd
			http://www.springframework.org/schema/jdbc
			http://www.springframework.org/schema/jdbc/spring-jdbc.xsd">
	</beans>

### Initialization

Unconditioned

	<jdbc:embedded-database id="dataSource">
		<jdbc:script location="classpath:schema.sql"/>
		<jdbc:script location="classpath:test-data.sql"/>
	</jdbc:embedded-database>

Can be disabled

	<jdbc:initialize-database data-source="dataSource" enabled="#{systemProperties.INITIALIZE_DATABASE}">
		<jdbc:script location="..."/>
	</jdbc:initialize-database>

Ignoring Failures

	<jdbc:initialize-database data-source="dataSource" ignore-failures="NONE|DROPS|ALL">
		<jdbc:script location="..."/>
	</jdbc:initialize-database>




