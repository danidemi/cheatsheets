# Build Helper

Add more source directories to your project, since pom.xml only allows one source directory.

    <project>
      ...
      <build>
        <plugins>
          <plugin>
            <groupId>org.codehaus.mojo</groupId>
            <artifactId>build-helper-maven-plugin</artifactId>
            <version>1.10</version>
            <executions>
              <execution>
                <id>add-source</id>
                <phase>generate-sources</phase>
                <goals>
                  <goal>add-source</goal>
                </goals>
                <configuration>
                  <sources>
                    <source>some directory</source>
                    ...
                  </sources>
                </configuration>
              </execution>
            </executions>
          </plugin>
        </plugins>
      </build>
    </project>

## References

<http://www.mojohaus.org/build-helper-maven-plugin/usage.html>