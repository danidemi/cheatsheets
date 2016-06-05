# Javadoc Plugin

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

# JDK 8, old projects

Old projects have probably javadoc comments that are not very well accepted by JDK8’s javadoc tool, namely ‘doclint’.

If you keep on receiving ERRORs about javadoc comments during the build process, try to disable ‘doclint’

## Base Approach

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

#### Profile Approach based on profiles

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
