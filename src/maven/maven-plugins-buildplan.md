# Buildplan Plugin

## Install it in a project

Prints out the list of phases and connected executions.

    <plugin>
        <!-- http://buildplan.jcgay.fr/usage.html -->
        <groupId>fr.jcgay.maven.plugins</groupId>
        <artifactId>buildplan-maven-plugin</artifactId>
        <version>1.2</version>
    </plugin>

## Install it is all projects

Since this is a general purpose plugin, you can also add it to your settings.xml in order to
have it available in all projects.

    <pluginGroups>
        <pluginGroup>fr.jcgay.maven.plugins</pluginGroup>
    </pluginGroups>


## References

* <https://github.com/jcgay/buildplan-maven-plugin>