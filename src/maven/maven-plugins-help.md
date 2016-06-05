# Help Plugin

[http://maven.apache.org/plugins/maven-help-plugin/](http://maven.apache.org/plugins/maven-help-plugin/)

	help:effective-pom

The effective pom, with dependencies from parent among other things.

	help:describe

Describe a plugin, a mvn command, etc... 
Here "org.apache." is probably added automatically as usual if not specified.

	mvn help:describe -Dcmd=deploy

	mvn help:describe -Dplugin=archetype 
